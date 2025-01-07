module 0xca6405616ba32b0716302a2e599dde413052bdd8b17169a513e5a2b1487113fc::bear {
    struct BEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAR>(arg0, 6, b"BEAR", b"SuiBEAR", b"SuiBEAR The cutest bear on SUI, bringing bear to the world of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000198353_50ae505f7f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

