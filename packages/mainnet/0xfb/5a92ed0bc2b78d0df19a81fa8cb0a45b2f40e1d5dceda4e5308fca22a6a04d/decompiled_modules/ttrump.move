module 0xfb5a92ed0bc2b78d0df19a81fa8cb0a45b2f40e1d5dceda4e5308fca22a6a04d::ttrump {
    struct TTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TTRUMP>(arg0, 6, b"TTRUMP", b"Terminal Trump", x"412066756c6c7920706f7765726564204149207477697474657220626f74206f66206f7572206661766f7269746520707265736964656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Jd_XH_rk_400x400_0b081cfed5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

