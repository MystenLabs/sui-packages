module 0x88c09ec2ade0bbb1ed72edc79deb982df578b14fb219df3b7304dcb20c396a7::magicom {
    struct MAGICOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGICOM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MAGICOM>(arg0, 6, b"MAGICOM", b"Magicom by SuiAI", b"Start new cooking", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000042074_9f1c614730.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MAGICOM>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGICOM>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

