module 0x3db4278d6c8c93eb2b9434d701c75b4ec86b94a7f4dc6d1966ad2a980109306f::kaitrump {
    struct KAITRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAITRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAITRUMP>(arg0, 6, b"KAITRUMP", b"Kai Trump", b"The GRANDDAUGHTER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732729521707.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAITRUMP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAITRUMP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

