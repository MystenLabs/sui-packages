module 0xffd466e450d85153592ab379887cb489a71f0c2112c2e3353cfba0a796bc81bd::bitmeme {
    struct BITMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: BITMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BITMEME>(arg0, 6, b"BITMEME", b"8 BIT MEME", b"I Choose MEME Everytime now shines on Sui with her own token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Tn_92_J6_O_400x400_28574d7d2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BITMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BITMEME>>(v1);
    }

    // decompiled from Move bytecode v6
}

