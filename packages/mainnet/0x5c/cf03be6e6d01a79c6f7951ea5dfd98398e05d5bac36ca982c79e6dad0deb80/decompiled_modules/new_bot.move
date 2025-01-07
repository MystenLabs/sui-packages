module 0x5ccf03be6e6d01a79c6f7951ea5dfd98398e05d5bac36ca982c79e6dad0deb80::new_bot {
    struct NEW_BOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEW_BOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEW_BOT>(arg0, 9, b"NEW_BOT", b"Bot for notification at PumpUp", b"There is a new telegram bot for a new meme coin notification!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/1aZVK4I.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NEW_BOT>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEW_BOT>>(v2, @0x96d9a120058197fce04afcffa264f2f46747881ba78a91beb38f103c60e315ae);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEW_BOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

