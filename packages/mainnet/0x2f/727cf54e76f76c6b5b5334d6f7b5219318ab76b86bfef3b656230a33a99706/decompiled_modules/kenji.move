module 0x2f727cf54e76f76c6b5b5334d6f7b5219318ab76b86bfef3b656230a33a99706::kenji {
    struct KENJI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KENJI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KENJI>(arg0, 6, b"KENJI", b"KENJI on SUI", b"$KENJI Is Bringing Utility And Fun Back To SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pw_J6c3k_400x400_a4ea2c0b0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KENJI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KENJI>>(v1);
    }

    // decompiled from Move bytecode v6
}

