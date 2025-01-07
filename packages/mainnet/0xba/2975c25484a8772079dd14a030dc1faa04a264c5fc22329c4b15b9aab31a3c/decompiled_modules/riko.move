module 0xba2975c25484a8772079dd14a030dc1faa04a264c5fc22329c4b15b9aab31a3c::riko {
    struct RIKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: RIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RIKO>(arg0, 6, b"RIKO", b"SUI RIKO", x"52696b6f2069732064657374696e656420746f206265206f6e65206f662074686520746f70206d656d6520636f696e73206f6e20746865206d61726b65742e204e6f20662a636b6e20646f7562742e202452494b4f0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hihihihihihih_e1020629e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RIKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RIKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

