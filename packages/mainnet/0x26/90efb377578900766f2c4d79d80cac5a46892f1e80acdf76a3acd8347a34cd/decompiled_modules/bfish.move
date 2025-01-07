module 0x2690efb377578900766f2c4d79d80cac5a46892f1e80acdf76a3acd8347a34cd::bfish {
    struct BFISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: BFISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BFISH>(arg0, 6, b"BFISH", b"Bread Fish", b"Have You Seen the Marvelous Breadfish?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_556acb995d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BFISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BFISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

