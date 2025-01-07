module 0x3e5ec906e6a740f4b13817665e277efc43ad84ef7f6e8d4013970f97143a13a7::krr {
    struct KRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRR>(arg0, 9, b"KRR", b"Kuroro", b"Kuroro beast", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2f96eef-d3b9-4a60-a899-9e6d728eab4c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

