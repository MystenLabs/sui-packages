module 0xceb4596b42a99c2a7a7e35d3f718ff159649c71fea7bb16d8eb2e31983946304::imp {
    struct IMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: IMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IMP>(arg0, 6, b"IMP", b"Impatience", b"Why be patient when you can be IMPATIENT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951815666.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

