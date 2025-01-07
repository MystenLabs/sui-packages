module 0xd3e4651c83d5b64b46f4b97f759713533f564cd93d400786ea66332ffbd4ac0c::sml {
    struct SML has drop {
        dummy_field: bool,
    }

    fun init(arg0: SML, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SML>(arg0, 6, b"SML", b"SHRIMPLE", b"Shrimple is a playful meme that combines the image of a shrimp with the word \"simple.\" It humorously captures the essence of simplicity while adding a fun seafood twist to everyday situations.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000038302_611931cbf4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SML>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SML>>(v1);
    }

    // decompiled from Move bytecode v6
}

