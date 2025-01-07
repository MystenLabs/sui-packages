module 0x86577a749dd093d4fc3a5421078d1db7cc59fa9958d4e27e4987856975630118::allus {
    struct ALLUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALLUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALLUS>(arg0, 6, b"AllUS", b"AIIUS", x"576520636f6d696e67207765e28099726520696e76657273652c207765e28099726520736e69706572732c207765e28099726520244149495553", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735494743279.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALLUS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALLUS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

