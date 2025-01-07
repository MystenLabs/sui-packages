module 0x6136b474539618e7054df49a96040e0fd66bde1cd8d7ecda5064acca7231e22b::gigachad {
    struct GIGACHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIGACHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIGACHAD>(arg0, 6, b"GIGACHAD", b"GIGA", b"Its the giga chad meme on Sui, the big one!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5977_f74ffcc64d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIGACHAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIGACHAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

