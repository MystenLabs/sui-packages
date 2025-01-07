module 0x3aa59469b0266474b1957b3362d916d7dd9bce9e9ff5f7a49de62c44170f461e::suiti {
    struct SUITI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITI>(arg0, 6, b"SUITI", b"Suiti (The Viral Cat)", b"$SUITI Is The Viral Cat Meme Coin Lands On Sui Network And Likes To Disturb Other Blockchain Network And Especially Memes Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_10_12_22_10_42_043_3436d33187.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITI>>(v1);
    }

    // decompiled from Move bytecode v6
}

