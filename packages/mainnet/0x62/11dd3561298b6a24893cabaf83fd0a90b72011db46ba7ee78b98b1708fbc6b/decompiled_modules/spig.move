module 0x6211dd3561298b6a24893cabaf83fd0a90b72011db46ba7ee78b98b1708fbc6b::spig {
    struct SPIG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIG>(arg0, 6, b"SPIG", b"Suiggy", b"Our goal is simple: to take over the meme coin market and change the investment game forever. Backed by a passionate community and viral potential, Suiggy has everything needed to skyrocket in value, turning small investments into life-changing returns.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001405_c28288fd17.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPIG>>(v1);
    }

    // decompiled from Move bytecode v6
}

