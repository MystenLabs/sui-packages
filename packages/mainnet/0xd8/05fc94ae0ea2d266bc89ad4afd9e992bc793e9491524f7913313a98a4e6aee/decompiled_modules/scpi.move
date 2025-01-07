module 0xd805fc94ae0ea2d266bc89ad4afd9e992bc793e9491524f7913313a98a4e6aee::scpi {
    struct AdminCap has key {
        id: 0x2::object::UID,
    }

    struct Pool has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<0x2::sui::SUI>,
        price: u64,
        supply: u64,
        issued_counter: u64,
        level: u8,
    }

    struct Grade<phantom T0> has key {
        id: 0x2::object::UID,
        amount: 0x2::balance::Balance<T0>,
        price: u64,
        level: u8,
    }

    struct Nft has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        n: u64,
        level: u8,
    }

    struct MintNFTEvent has copy, drop {
        id: u64,
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    public entry fun public_transfer(arg0: Nft, arg1: address) {
        0x2::transfer::public_transfer<Nft>(arg0, arg1);
    }

    public fun url(arg0: &Nft) : &0x2::url::Url {
        &arg0.url
    }

    public entry fun burn(arg0: Nft) {
        let Nft {
            id          : v0,
            name        : _,
            description : _,
            url         : _,
            n           : _,
            level       : _,
        } = arg0;
        0x2::object::delete(v0);
    }

    public entry fun create_grade<T0>(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = arg1.level + 1;
        arg1.level = v0;
        let v1 = Grade<T0>{
            id     : 0x2::object::new(arg3),
            amount : 0x2::balance::zero<T0>(),
            price  : arg2,
            level  : v0,
        };
        0x2::transfer::share_object<Grade<T0>>(v1);
    }

    public fun description(arg0: &Nft) : &0x1::string::String {
        &arg0.description
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = Pool{
            id             : 0x2::object::new(arg0),
            amount         : 0x2::balance::zero<0x2::sui::SUI>(),
            price          : 400000000000,
            supply         : 1200,
            issued_counter : 0,
            level          : 1,
        };
        0x2::transfer::share_object<Pool>(v1);
    }

    public entry fun mint(arg0: &mut Pool, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.price > 0, 1);
        assert!(arg0.issued_counter < arg0.supply, 1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.amount, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg1, arg0.price, arg5)));
        if (0x2::coin::value<0x2::sui::SUI>(&arg1) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg1);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, 0x2::tx_context::sender(arg5));
        };
        let v0 = arg0.issued_counter + 1;
        arg0.issued_counter = v0;
        mint_nft(arg2, arg3, arg4, v0, arg5);
    }

    fun mint_nft(arg0: vector<u8>, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = Nft{
            id          : 0x2::object::new(arg4),
            name        : 0x1::string::utf8(arg0),
            description : 0x1::string::utf8(arg1),
            url         : 0x2::url::new_unsafe_from_bytes(arg2),
            n           : arg3,
            level       : 1,
        };
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = MintNFTEvent{
            id        : arg3,
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<Nft>(v0, v1);
    }

    public fun minted(arg0: &Pool) : &u64 {
        &arg0.issued_counter
    }

    public fun name(arg0: &Nft) : &0x1::string::String {
        &arg0.name
    }

    public entry fun update_description(arg0: &mut Nft, arg1: vector<u8>) {
        arg0.description = 0x1::string::utf8(arg1);
    }

    public entry fun update_grade<T0>(arg0: &AdminCap, arg1: &mut Grade<T0>, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    public entry fun update_level<T0>(arg0: &mut Grade<T0>, arg1: &mut Nft, arg2: vector<u8>, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::balance::join<T0>(&mut arg0.amount, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, arg0.price, arg4)));
        if (0x2::coin::value<T0>(&arg3) == 0) {
            0x2::coin::destroy_zero<T0>(arg3);
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg3, 0x2::tx_context::sender(arg4));
        };
        assert!(arg0.level - 1 == arg1.level, 1);
        arg1.level = arg0.level;
        arg1.url = 0x2::url::new_unsafe_from_bytes(arg2);
    }

    public entry fun update_price(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.price = arg2;
    }

    public entry fun update_supply(arg0: &AdminCap, arg1: &mut Pool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.supply = arg2;
    }

    public entry fun withdraw_grade<T0>(arg0: &AdminCap, arg1: &mut Grade<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg1.amount), arg2), 0x2::tx_context::sender(arg2));
    }

    public entry fun withdraw_pool(arg0: &AdminCap, arg1: &mut Pool, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg1.amount), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

