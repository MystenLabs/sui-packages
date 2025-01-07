module 0xef5a15745495948d52b7da1c304094b348bdd5eb38967c932b31a2578787d8ea::booboo {
    struct BOOBOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOBOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOBOO>(arg0, 6, b"BOOBOO", b"Boo Boo Ninja", x"426f6f20426f6f2074686520756e646572646f67206973206f6e2061206d697373696f6e206f6620236d656d65730a57652077616e742023646567656e7320746861742076616c75652050505020696e7374656164206f6620507650", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/android_icon_192x192_fa7eacb5c0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOBOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOBOO>>(v1);
    }

    // decompiled from Move bytecode v6
}

