module 0x2af8ae1b59c500419cd3f5e855a6e8b3dc25f43ccff5b084f95ea01b8855e7bb::ticket_meme_01_05_2024 {
    struct TICKET_MEME_01_05_2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TICKET_MEME_01_05_2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TICKET_MEME_01_05_2024>(arg0, 6, b"ticket_MEME_01_05_2024", b"TicketFormeme01052024", b"Pre sale ticket of bonding curve pool for the following memecoin: meme01052024", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TICKET_MEME_01_05_2024>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TICKET_MEME_01_05_2024>>(v2, @0x9636ead2159f25e1f269223d53d51f0065915a5255fecab0ff1485ab8c64eeec);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TICKET_MEME_01_05_2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

