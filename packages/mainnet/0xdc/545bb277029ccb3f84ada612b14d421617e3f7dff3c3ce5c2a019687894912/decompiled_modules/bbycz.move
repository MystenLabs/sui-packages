module 0xdc545bb277029ccb3f84ada612b14d421617e3f7dff3c3ce5c2a019687894912::bbycz {
    struct BBYCZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBYCZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBYCZ>(arg0, 9, b"Bbycz", x"62616279637a2e7375c4b1", b"a commemorative meme nft released in the sui ecosystem in memory of binance cz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/69abca2faff7822f1c8c4992fd1dd989blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBYCZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBYCZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

