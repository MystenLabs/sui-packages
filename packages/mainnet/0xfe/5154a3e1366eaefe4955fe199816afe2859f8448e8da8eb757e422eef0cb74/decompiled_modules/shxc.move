module 0xfe5154a3e1366eaefe4955fe199816afe2859f8448e8da8eb757e422eef0cb74::shxc {
    struct SHXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHXC>(arg0, 6, b"SHXC", b"SHXC Coin", b"SHXC Coin is the utility token of the S.H SmartHub ecosystem, connecting digital commerce, electronics repair, rewards and circular technology across S.H SmartHub and RepairX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1790405862045.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHXC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHXC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

