module 0x25ab8442053eee1373df900ab5f0c2b1ae170f452260158c59c7220a08682fe2::mus {
    struct MUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUS>(arg0, 6, b"MUS", b"Meme United", b"Drop Man United, Meme United has came to SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/100_copy_5_2x_8_1bbd33268b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

