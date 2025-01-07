module 0x44532acd5c5e25ac61e5d407f7a78ddd3d9889c063f8b277469444bee6487ea0::jar {
    struct JAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JAR>(arg0, 9, b"JAR", b"Jar dog", b"Jardog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/44838f72-41c3-4c18-921a-ad9ba9874edb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

