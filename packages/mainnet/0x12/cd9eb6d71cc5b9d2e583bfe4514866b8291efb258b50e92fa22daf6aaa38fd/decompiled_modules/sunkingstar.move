module 0x12cd9eb6d71cc5b9d2e583bfe4514866b8291efb258b50e92fa22daf6aaa38fd::sunkingstar {
    struct SUNKINGSTAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUNKINGSTAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUNKINGSTAR>(arg0, 6, b"SunKingStar", b"Sun King Star", b"Meme to salute the Sun King Star!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000106185_e090cefe44.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUNKINGSTAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUNKINGSTAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

