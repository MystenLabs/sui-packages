module 0x70e4cc3b0ffc8d676e3133977ea559a222e00b6b361718e916e6cfa655fae5f8::fartcoin {
    struct FARTCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<FARTCOIN>(arg0, 6, b"FARTCOIN", b"Fartcoin by SuiAI", x"546f6b656e6973696e672066617274732077697468207468652068656c70206f6620626f74732e20204e6f2054472c206e6f20636162616c2c206661727420667265656c792120496620796f75206d6973736564206974206f6e20536f6c616e612c20646f6ee2809974206d697373206974206f6e205375692120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/ISIMG_820921_933c53e60d.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FARTCOIN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCOIN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

