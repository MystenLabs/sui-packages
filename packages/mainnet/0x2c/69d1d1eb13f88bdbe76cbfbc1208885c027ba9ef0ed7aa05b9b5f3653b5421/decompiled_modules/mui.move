module 0x2c69d1d1eb13f88bdbe76cbfbc1208885c027ba9ef0ed7aa05b9b5f3653b5421::mui {
    struct MUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUI>(arg0, 6, b"MUI", b"mui", x"6d7569206f6e207375690a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730956144386.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

