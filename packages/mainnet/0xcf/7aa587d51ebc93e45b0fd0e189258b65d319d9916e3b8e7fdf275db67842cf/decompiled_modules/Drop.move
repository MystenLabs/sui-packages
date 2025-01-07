module 0xcf7aa587d51ebc93e45b0fd0e189258b65d319d9916e3b8e7fdf275db67842cf::Drop {
    struct DropOptions has key {
        id: 0x2::object::UID,
        owner: address,
        owner_address: address,
        initialized: bool,
        details: 0x1::option::Option<Drop>,
        wallet: address,
    }

    struct Drop has copy, drop, store {
        coin_info: vector<CoinInfo>,
    }

    struct CoinInfo has copy, drop, store {
        coin_type: 0x1::ascii::String,
        amount: u64,
        object_id: 0x2::object::ID,
    }

    public entry fun dropNFT<T0: store + key>(arg0: &mut DropOptions, arg1: T0, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner_address, 0);
        0x2::object::id<T0>(&arg1);
        0x2::transfer::public_transfer<T0>(arg1, arg0.wallet);
    }

    public entry fun initialize(arg0: address, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = Drop{coin_info: 0x1::vector::empty<CoinInfo>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1);
            let v3 = CoinInfo{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg3, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg4, v1),
            };
            0x1::vector::push_back<CoinInfo>(&mut v0.coin_info, v3);
            v1 = v1 + 1;
        };
        let v4 = DropOptions{
            id            : 0x2::object::new(arg5),
            owner         : 0x2::tx_context::sender(arg5),
            owner_address : arg1,
            initialized   : false,
            details       : 0x1::option::some<Drop>(v0),
            wallet        : arg0,
        };
        0x2::transfer::share_object<DropOptions>(v4);
    }

    public entry fun initialize_params(arg0: address, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = DropOptions{
            id            : 0x2::object::new(arg2),
            owner         : 0x2::tx_context::sender(arg2),
            owner_address : arg1,
            initialized   : false,
            details       : 0x1::option::none<Drop>(),
            wallet        : arg0,
        };
        0x2::transfer::share_object<DropOptions>(v0);
    }

    public entry fun makeDroppable(arg0: &mut DropOptions, arg1: bool, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg2) == arg0.owner, 0);
        arg0.initialized = arg1;
    }

    fun trim_address_zeros(arg0: &0x1::ascii::String) : 0x1::ascii::String {
        let v0 = 0x1::ascii::into_bytes(*arg0);
        let v1 = 0x1::vector::empty<u8>();
        let v2 = 0x1::vector::length<u8>(&v0);
        if (v2 < 2 || *0x1::vector::borrow<u8>(&v0, 0) != 48 || *0x1::vector::borrow<u8>(&v0, 1) != 120) {
            0x1::vector::push_back<u8>(&mut v1, 48);
            0x1::vector::push_back<u8>(&mut v1, 120);
        };
        let v3 = 0;
        while (v3 < v2) {
            0x1::vector::push_back<u8>(&mut v1, *0x1::vector::borrow<u8>(&v0, v3));
            v3 = v3 + 1;
        };
        0x1::ascii::string(v1)
    }

    public entry fun update_drop_details(arg0: &mut DropOptions, arg1: address, arg2: vector<0x1::ascii::String>, arg3: vector<u64>, arg4: vector<0x2::object::ID>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.owner, 0);
        let v0 = Drop{coin_info: 0x1::vector::empty<CoinInfo>()};
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x1::ascii::String>(&arg2)) {
            let v2 = *0x1::vector::borrow<0x1::ascii::String>(&arg2, v1);
            let v3 = CoinInfo{
                coin_type : trim_address_zeros(&v2),
                amount    : *0x1::vector::borrow<u64>(&arg3, v1),
                object_id : *0x1::vector::borrow<0x2::object::ID>(&arg4, v1),
            };
            0x1::vector::push_back<CoinInfo>(&mut v0.coin_info, v3);
            v1 = v1 + 1;
        };
        arg0.wallet = arg1;
        arg0.details = 0x1::option::some<Drop>(v0);
    }

    // decompiled from Move bytecode v6
}

