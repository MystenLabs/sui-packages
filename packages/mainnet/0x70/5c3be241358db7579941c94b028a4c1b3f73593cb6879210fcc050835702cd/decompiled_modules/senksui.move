module 0x705c3be241358db7579941c94b028a4c1b3f73593cb6879210fcc050835702cd::senksui {
    struct SENKSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENKSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SENKSUI>(arg0, 6, b"SENKSUI", b"SENK SUI MEME", b"Hey, I'm Senk, and I'm the coolest seal on Solana! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1726079406000_bf89bf43dbc6ff64bc210cc79959d78f_470f86dc1f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENKSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENKSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

