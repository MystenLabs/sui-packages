module 0x859265b816bcc5e05604f07e3c4c933d6e949a16a60b013bb1aea64e002678ab::xika {
    struct XIKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XIKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XIKA>(arg0, 6, b"XIKA", b"Xika Girls", b"$XIKA | Waifu NFTs  for one on one DM chat with your favourite Xika Girl. Holding $XIKA gives you exclusive perks and access to the public chat with Xika Chan and whitelist spots for the mint.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiciwv3nwldhf75tut46aunfmremoksa66vwt3nuio7z76t44742xu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XIKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<XIKA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

