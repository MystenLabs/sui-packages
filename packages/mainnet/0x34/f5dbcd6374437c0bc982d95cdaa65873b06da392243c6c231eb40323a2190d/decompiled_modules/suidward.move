module 0x34f5dbcd6374437c0bc982d95cdaa65873b06da392243c6c231eb40323a2190d::suidward {
    struct SUIDWARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDWARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDWARD>(arg0, 6, b"Suidward", b"$SWARD", b"$SWARD is a fun and quirky project that combines the best of SUI blockchain with the beloved character Squidward from SpongeBob SquarePants.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/logo_token_1537a5e11f.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDWARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDWARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

