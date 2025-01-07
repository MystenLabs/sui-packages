module 0xf4cd8eea3e826c065715ea6095690101b92b4c9257c54272f3126dec34caeb17::sphynk {
    struct SPHYNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPHYNK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPHYNK>(arg0, 6, b"SPHYNK", b"Sphynk on sui", b"Start spinning, mining and battle", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000042489_c444d81334.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPHYNK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPHYNK>>(v1);
    }

    // decompiled from Move bytecode v6
}

