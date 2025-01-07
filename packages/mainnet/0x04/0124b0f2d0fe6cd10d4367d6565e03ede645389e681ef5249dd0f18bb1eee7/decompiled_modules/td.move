module 0x40124b0f2d0fe6cd10d4367d6565e03ede645389e681ef5249dd0f18bb1eee7::td {
    struct TD has drop {
        dummy_field: bool,
    }

    fun init(arg0: TD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TD>(arg0, 6, b"TD", b"Trippy Duck", b"Trippy Duck, addicted to acid, joining solana to spread the hype. WARNING ,Loocking at these Duck for more than 10 sec may blow your Mind .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_04_17_20_29_25_16a9cf803e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TD>>(v1);
    }

    // decompiled from Move bytecode v6
}

