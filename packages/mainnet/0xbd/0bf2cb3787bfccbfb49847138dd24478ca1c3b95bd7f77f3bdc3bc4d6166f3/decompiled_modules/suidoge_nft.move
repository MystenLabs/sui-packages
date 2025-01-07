module 0xbd0bf2cb3787bfccbfb49847138dd24478ca1c3b95bd7f77f3bdc3bc4d6166f3::suidoge_nft {
    struct SUIDOGE_NFT has drop {
        dummy_field: bool,
    }

    struct SuiDogeNFT has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        img_url: 0x2::url::Url,
    }

    struct MintNFTEvent has copy, drop {
        object_id: 0x2::object::ID,
        creator: address,
        name: 0x1::string::String,
    }

    struct Counter has key {
        id: 0x2::object::UID,
        count: u64,
        freeCount: u64,
        userMaxCount: u64,
        maxCount: u64,
        maxCount2: u64,
    }

    struct UserCounter has key {
        id: 0x2::object::UID,
    }

    struct PoolBalance has key {
        id: 0x2::object::UID,
        price: u64,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct OwnerCap has key {
        id: 0x2::object::UID,
    }

    public fun checkUser(arg0: u64, arg1: &mut UserCounter, arg2: &mut Counter, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0 <= arg2.userMaxCount, 30);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = if (0x2::dynamic_field::exists_with_type<address, u64>(&arg1.id, v0)) {
            let v2 = 0x2::dynamic_field::remove<address, u64>(&mut arg1.id, v0);
            assert!(v2 + arg0 <= arg2.userMaxCount, 33);
            v2
        } else {
            0
        };
        0x2::dynamic_field::add<address, u64>(&mut arg1.id, v0, v1 + arg0);
    }

    public fun description(arg0: &SuiDogeNFT) : &0x1::string::String {
        &arg0.description
    }

    public fun img_url(arg0: &SuiDogeNFT) : &0x2::url::Url {
        &arg0.img_url
    }

    fun init(arg0: SUIDOGE_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OwnerCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OwnerCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = &mut v1;
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"name"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"image_url"));
        0x1::vector::push_back<0x1::string::String>(v2, 0x1::string::utf8(b"description"));
        let v3 = 0x1::vector::empty<0x1::string::String>();
        let v4 = &mut v3;
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{name}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{img_url}"));
        0x1::vector::push_back<0x1::string::String>(v4, 0x1::string::utf8(b"{description}"));
        let v5 = Counter{
            id           : 0x2::object::new(arg1),
            count        : 0,
            freeCount    : 0,
            userMaxCount : 5,
            maxCount     : 10000,
            maxCount2    : 100000,
        };
        let v6 = 0x2::package::claim<SUIDOGE_NFT>(arg0, arg1);
        let v7 = 0x2::display::new_with_fields<SuiDogeNFT>(&v6, v1, v3, arg1);
        0x2::display::update_version<SuiDogeNFT>(&mut v7);
        0x2::transfer::public_transfer<0x2::package::Publisher>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::display::Display<SuiDogeNFT>>(v7, 0x2::tx_context::sender(arg1));
        0x2::transfer::share_object<Counter>(v5);
        let v8 = UserCounter{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<UserCounter>(v8);
        let v9 = PoolBalance{
            id      : 0x2::object::new(arg1),
            price   : 1000000000,
            balance : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        0x2::transfer::share_object<PoolBalance>(v9);
    }

    public fun mint(arg0: &mut Counter, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = SuiDogeNFT{
            id          : 0x2::object::new(arg1),
            name        : 0x1::string::utf8(b"SuiDoge"),
            description : 0x1::string::utf8(b"NFT is our Non-Fungible Token, equivalent to an pass card, and having an NFT owns half of SuiDoge's tokens. In the later stage, attributes such as pledge and voting governance will be developed. In short, his value is infinite, we take in the very beginning to realize him, which shows that he is very important"),
            img_url     : 0x2::url::new_unsafe_from_bytes(b"https://suidoge.dog/sui/suidogenft.png"),
        };
        let v1 = 0x2::tx_context::sender(arg1);
        let v2 = MintNFTEvent{
            object_id : 0x2::object::uid_to_inner(&v0.id),
            creator   : v1,
            name      : v0.name,
        };
        0x2::event::emit<MintNFTEvent>(v2);
        0x2::transfer::public_transfer<SuiDogeNFT>(v0, v1);
        arg0.count = arg0.count + 1;
    }

    public entry fun mint10(arg0: u64, arg1: &mut UserCounter, arg2: &mut Counter, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.freeCount < arg2.maxCount, 22);
        checkUser(arg0, arg1, arg2, arg3);
        mint_multi(arg0, arg2, arg3);
        arg2.freeCount = arg2.freeCount + arg0;
    }

    public entry fun mint20(arg0: u64, arg1: &mut UserCounter, arg2: &mut Counter, arg3: &mut PoolBalance, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg2.count < arg2.maxCount2, 11);
        checkUser(arg0, arg1, arg2, arg5);
        let v0 = 0x2::coin::into_balance<0x2::sui::SUI>(arg4);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v0) == arg3.price * arg0, 44);
        0x2::balance::join<0x2::sui::SUI>(&mut arg3.balance, v0);
        mint_multi(arg0, arg2, arg5);
    }

    public fun mint_multi(arg0: u64, arg1: &mut Counter, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0;
        while (v0 < arg0) {
            mint(arg1, arg2);
            v0 = v0 + 1;
        };
    }

    public fun name(arg0: &SuiDogeNFT) : &0x1::string::String {
        &arg0.name
    }

    public entry fun withdraw(arg0: &OwnerCap, arg1: &mut PoolBalance, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::take<0x2::sui::SUI>(&mut arg1.balance, 0x2::balance::value<0x2::sui::SUI>(&arg1.balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

