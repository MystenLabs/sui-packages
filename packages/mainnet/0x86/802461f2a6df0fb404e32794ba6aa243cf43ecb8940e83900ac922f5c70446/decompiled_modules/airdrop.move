module 0x86802461f2a6df0fb404e32794ba6aa243cf43ecb8940e83900ac922f5c70446::airdrop {
    struct Info has store {
        level: u64,
        is_claimed_nft: bool,
        is_claimed_token: bool,
    }

    struct Pool<phantom T0> has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<T0>,
        address2level: 0x2::vec_map::VecMap<address, Info>,
    }

    struct MovexOG has store, key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        url: 0x2::url::Url,
        level: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    public entry fun check_if_eligible<T0>(arg0: &mut Pool<T0>, arg1: address) : (bool, 0x1::option::Option<u64>) {
        if (0x2::vec_map::contains<address, Info>(&arg0.address2level, &arg1)) {
            let v0 = 0;
            let v1 = 0x2::vec_map::get<address, Info>(&arg0.address2level, &arg1);
            if (v1.level == 2) {
                v0 = 200;
            };
            if (v1.level == 3) {
                v0 = 400;
            };
            if (v1.level == 4) {
                v0 = 4000;
            };
            return (true, 0x1::option::some<u64>(v0))
        };
        (false, 0x1::option::none<u64>())
    }

    public fun create_pool<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = Pool<T0>{
            id            : 0x2::object::new(arg1),
            balance       : 0x2::coin::into_balance<T0>(arg0),
            address2level : 0x2::vec_map::empty<address, Info>(),
        };
        0x2::transfer::share_object<Pool<T0>>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
    }

    public entry fun insert_address<T0>(arg0: &AdminCap, arg1: &mut Pool<T0>, arg2: address, arg3: u64) {
        assert!(arg3 == 1 || arg3 == 2 || arg3 == 3 || arg3 == 4, 2);
        let v0 = Info{
            level            : arg3,
            is_claimed_nft   : false,
            is_claimed_token : false,
        };
        0x2::vec_map::insert<address, Info>(&mut arg1.address2level, arg2, v0);
    }

    public entry fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MovexOG{
            id          : 0x2::object::new(arg0),
            name        : 0x1::string::utf8(b"MovEX OG SEISI"),
            description : 0x1::string::utf8(b"NFT of MovEX"),
            url         : 0x2::url::new_unsafe_from_bytes(b"https://github.com/wiggins-dev/demo/blob/main/OG.gif"),
            level       : 2,
        };
        0x2::transfer::public_transfer<MovexOG>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

