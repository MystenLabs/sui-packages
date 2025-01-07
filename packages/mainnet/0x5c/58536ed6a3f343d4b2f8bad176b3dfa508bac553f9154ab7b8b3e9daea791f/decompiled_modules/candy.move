module 0xd486adf50a03ff0cee58e3cbf3aa74a4f8c4755f588f8abd9e87014f092546a5::candy {
    struct CANDY has drop {
        dummy_field: bool,
    }

    struct TreasuryConfigurationCap has key {
        id: 0x2::object::UID,
    }

    fun create_treasury_configuration_cap(arg0: &mut CANDY, arg1: &mut 0x2::tx_context::TxContext) : TreasuryConfigurationCap {
        TreasuryConfigurationCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: CANDY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        let v1 = create_treasury_configuration_cap(v0, arg1);
        let (v2, v3) = 0x2::coin::create_currency<CANDY>(arg0, 5, b"CANDY", b"CandyCoin", b"Jump into my van, kiddo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1747677278249648128/9iTtqgcj_400x400.jpg")), arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<CANDY>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::transfer<TreasuryConfigurationCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CANDY>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CANDY>>(v4);
    }

    // decompiled from Move bytecode v6
}

