module 0x708facefb95190651bdb5606ab535de204affd74a5ab9363340281875c901ff4::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 9, b"SPARK", b"Spark", b"Tony Spark", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01a78745-eac6-4050-aaf5-bad620c60472.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

