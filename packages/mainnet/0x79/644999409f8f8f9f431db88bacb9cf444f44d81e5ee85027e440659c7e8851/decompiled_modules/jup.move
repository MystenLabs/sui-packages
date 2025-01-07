module 0xd8f04cd2a16c19c17428c3b4c22b01dd06740423b93fb7ee88fbe2676a82849d::jup {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<JUP>,
    }

    struct JUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JUP>(arg0, 8, b"JUP", b"Typus JUP", b"JUP on Sui maintained by Typus Lab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/JUP.svg")), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUP>>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    // decompiled from Move bytecode v6
}

