module 0x48761d9fac504764fea98235b7e0dfa8301dd844f5e34e43c18bda98aff3b432::nisu {
    struct NISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NISU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NISU>(arg0, 6, b"NISU", b"Nisu The Cat", b"Born from the light of a new star, $Nisu rises to brighten the Sui skies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/nisu_4aaf6f6531.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NISU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NISU>>(v1);
    }

    // decompiled from Move bytecode v6
}

