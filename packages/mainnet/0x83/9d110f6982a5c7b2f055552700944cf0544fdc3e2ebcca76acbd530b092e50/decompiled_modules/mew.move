module 0x839d110f6982a5c7b2f055552700944cf0544fdc3e2ebcca76acbd530b092e50::mew {
    struct MEW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEW>(arg0, 6, b"MEW", b"MeowWoof", b"Once upon a time, in the bustling city of SuiVille,  a fierce rivalry existed between two factions: the memes of cats and the dogs. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mew_a9c633cefe.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEW>>(v1);
    }

    // decompiled from Move bytecode v6
}

