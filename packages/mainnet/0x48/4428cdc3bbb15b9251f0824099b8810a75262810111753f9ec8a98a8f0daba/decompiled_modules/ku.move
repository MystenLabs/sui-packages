module 0x484428cdc3bbb15b9251f0824099b8810a75262810111753f9ec8a98a8f0daba::ku {
    struct KU has drop {
        dummy_field: bool,
    }

    fun init(arg0: KU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KU>(arg0, 9, b"KU", b"Kuturbo", b"Kucing malay", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/17106f21-b982-40e1-92f6-4f0d6acf0f6f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KU>>(v1);
    }

    // decompiled from Move bytecode v6
}

