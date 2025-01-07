module 0x451b7d5ea45b59a68fb7e4c1f5cc246976e6ea2c86418e1ddab4ab2f55b0de5c::verse {
    struct VERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: VERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VERSE>(arg0, 6, b"Verse", b"Verse on sui", b"$Verse is the ultimate burnout sponge memecoinrelatable, hilarious, and ready to absorb memes, dreams, and streams of gains. No stress, just Pulse it up.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/3_8efd32ff11.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VERSE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VERSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

