module 0xbbba13281a7b2091a979c81645967604412906dda7fbe5f07e195501a4b2b261::insta_management {
    struct INSTA_MANAGEMENT has drop {
        dummy_field: bool,
    }

    struct CreatorCap has key {
        id: 0x2::object::UID,
    }

    struct SignerCap has key {
        id: 0x2::object::UID,
        version: u64,
    }

    struct InstaConfig has key {
        id: 0x2::object::UID,
        isInited: bool,
        creator: address,
        is_request_withdraw: bool,
        is_freezed: bool,
        rate_limit_per_hour: u64,
        version: u64,
    }

    struct Deposited has key {
        id: 0x2::object::UID,
        amount: u64,
    }

    public entry fun add_deposit() {
    }

    public entry fun authorize_insta_signer(arg0: &mut InstaConfig, arg1: &CreatorCap, arg2: address, arg3: bool, arg4: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            arg0.version = arg0.version + 1;
        };
        let v0 = SignerCap{
            id      : 0x2::object::new(arg4),
            version : arg0.version,
        };
        0x2::transfer::transfer<SignerCap>(v0, arg2);
    }

    fun init(arg0: INSTA_MANAGEMENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = CreatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<CreatorCap>(v0, 0x2::tx_context::sender(arg1));
        let v1 = InstaConfig{
            id                  : 0x2::object::new(arg1),
            isInited            : true,
            creator             : 0x2::tx_context::sender(arg1),
            is_request_withdraw : false,
            is_freezed          : false,
            rate_limit_per_hour : 100,
            version             : 0,
        };
        0x2::transfer::share_object<InstaConfig>(v1);
    }

    public entry fun mint(arg0: &InstaConfig, arg1: &SignerCap, arg2: vector<u8>, arg3: vector<u8>, arg4: vector<u8>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.version == arg0.version, 0);
        assert!(arg0.is_freezed == false, 0);
        0xbbba13281a7b2091a979c81645967604412906dda7fbe5f07e195501a4b2b261::insta_nft::mint(arg2, arg3, arg4, arg0.creator, arg5);
    }

    // decompiled from Move bytecode v6
}

