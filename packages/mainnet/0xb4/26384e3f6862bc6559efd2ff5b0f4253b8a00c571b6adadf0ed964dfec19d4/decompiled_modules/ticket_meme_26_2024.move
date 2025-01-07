module 0xb426384e3f6862bc6559efd2ff5b0f4253b8a00c571b6adadf0ed964dfec19d4::ticket_meme_26_2024 {
    struct TICKET_MEME_26_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKET_MEME_26_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKET_MEME_26_2024>(arg0, 6, b"ticket_MEME_26_2024", b"TicketFormeme262024", b"Pre sale ticket of bonding curve pool for the following memecoin: meme262024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKET_MEME_26_2024>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKET_MEME_26_2024>>(v2, @0x42dbd0fea6fefd7689d566287581724151b5327c08b76bdb9df108ca3b48d1d5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKET_MEME_26_2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

