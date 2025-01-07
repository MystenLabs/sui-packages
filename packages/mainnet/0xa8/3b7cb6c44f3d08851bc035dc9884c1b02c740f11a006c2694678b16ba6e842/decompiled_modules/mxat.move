module 0xa83b7cb6c44f3d08851bc035dc9884c1b02c740f11a006c2694678b16ba6e842::mxat {
    struct MXAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MXAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MXAT>(arg0, 9, b"MXAT", b"Meme", b"Usuahsh", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/67fa6f3b-d0f8-4226-ae94-21ed5255f4de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MXAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MXAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

