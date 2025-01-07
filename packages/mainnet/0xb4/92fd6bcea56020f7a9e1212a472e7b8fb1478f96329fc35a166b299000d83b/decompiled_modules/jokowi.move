module 0xb492fd6bcea56020f7a9e1212a472e7b8fb1478f96329fc35a166b299000d83b::jokowi {
    struct JOKOWI has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOKOWI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOKOWI>(arg0, 9, b"JOKOWI", b"JOKOWI ", b"JOKO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5fe44aef-c117-4df1-9443-02b643a0fadb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOKOWI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JOKOWI>>(v1);
    }

    // decompiled from Move bytecode v6
}

