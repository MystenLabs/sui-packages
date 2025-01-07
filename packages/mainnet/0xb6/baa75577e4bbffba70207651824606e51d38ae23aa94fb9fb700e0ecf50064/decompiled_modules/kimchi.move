module 0xb6baa75577e4bbffba70207651824606e51d38ae23aa94fb9fb700e0ecf50064::kimchi {
    struct KIMCHI has drop {
        dummy_field: bool,
    }

    struct TreasuryConfigurationCap has key {
        id: 0x2::object::UID,
    }

    fun create_treasury_configuration_cap(arg0: &mut KIMCHI, arg1: &mut 0x2::tx_context::TxContext) : TreasuryConfigurationCap {
        TreasuryConfigurationCap{id: 0x2::object::new(arg1)}
    }

    fun init(arg0: KIMCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = &mut arg0;
        let v1 = create_treasury_configuration_cap(v0, arg1);
        let (v2, v3) = 0x2::coin::create_currency<KIMCHI>(arg0, 5, b"KIMCHI", b"KIMCHI", x"4b696d636869207374616e647320617320612073796d626f6c206f662074686520417369616e206275696c64657220636f6d6d756e697479e280997320696e6e6f766174696f6e20616e6420637265617469766974792c2073657276696e67206173206120706c6174666f726d20666f7220696e646976696475616c7320746f20636f6c6c61626f726174652c2065786368616e67652069646561732c20616e6420707573682074686520626f756e646172696573206f6620646563656e7472616c697a65642066696e616e63652e2054686520636f696e2061696d7320746f20666f726d20616e20756e73746f707061626c6520666f7263652077697468696e20746865205375692065636f73797374656d2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://assets.kimchi.gg/CoinLogo.png")), arg1);
        let v4 = v2;
        0x2::coin::mint_and_transfer<KIMCHI>(&mut v4, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::transfer<TreasuryConfigurationCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KIMCHI>>(v3);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KIMCHI>>(v4);
    }

    // decompiled from Move bytecode v6
}

