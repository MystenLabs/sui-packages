module 0x3409c511c862c720999bbc89d7b12b694876014fdd593a370553fc2e52582c96::noreally {
    struct NOREALLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOREALLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOREALLY>(arg0, 6, b"NOREALLY", b"No really this is the best dog", b"No really, this is the best dog, maybe ever. Definitely the best dog we've ever seen. No socials. No rug. Just look at this dog. No really, look, it's the best dog ever.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/no_really_0f2210c924.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOREALLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOREALLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

