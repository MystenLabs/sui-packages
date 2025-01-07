module 0xc38c12788e0334492f61b9ba04d550f85201089e176bcf7bed4b3f4f899b97b6::sproto {
    struct SPROTO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPROTO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPROTO>(arg0, 6, b"SPROTO", b"BLUE SPROTO", b"Gremlins official mascot on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3762_756726707f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPROTO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPROTO>>(v1);
    }

    // decompiled from Move bytecode v6
}

