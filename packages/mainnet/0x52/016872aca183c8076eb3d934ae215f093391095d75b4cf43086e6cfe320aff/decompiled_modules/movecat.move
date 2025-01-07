module 0x52016872aca183c8076eb3d934ae215f093391095d75b4cf43086e6cfe320aff::movecat {
    struct MOVECAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOVECAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOVECAT>(arg0, 6, b"MOVECAT", b"Cat on the move", b"Cat on the move is a art and story line based meme on Sui. Posting daily content on X to create more awareness about the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2467_dbf8914ca5.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOVECAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOVECAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

