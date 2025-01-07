module 0x17e3b9a65de95a5fc5f8e9b9c81b8c4c59e6f2849d57f7314a7c2be145e55c73::hotsui {
    struct HOTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOTSUI>(arg0, 6, b"HOTSUI", b"$HOTSUI", b"\"$HOTSUI is taking Telegram by storm with its super cool stickers! Are you ready to explore this new meme coin on Tonblockchain? Join our community and let's write the next success story together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ptichka_500_500_px_5c646449f0.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOTSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

