module 0xcac46c81bbe1e516c65f4c3e5da81e7092cc2e70218deafb31f1c8d5fcc9dae3::inj {
    struct Registry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<INJ>,
    }

    struct INJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: INJ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<INJ>(arg0, 8, b"INJ", b"Typus INJ", b"INJ on Sui maintained by Typus Lab", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://raw.githubusercontent.com/Typus-Lab/typus-asset/main/assets/INJ.svg")), arg1);
        let v2 = Registry{
            id           : 0x2::object::new(arg1),
            treasury_cap : v0,
        };
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<INJ>>(v1);
        0x2::transfer::share_object<Registry>(v2);
    }

    // decompiled from Move bytecode v6
}

