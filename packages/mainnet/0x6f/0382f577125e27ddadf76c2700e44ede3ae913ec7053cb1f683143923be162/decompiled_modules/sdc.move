module 0x6f0382f577125e27ddadf76c2700e44ede3ae913ec7053cb1f683143923be162::sdc {
    struct SDC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDC>(arg0, 6, b"SDC", b"SirDogeoftheCoin", b"Sir Doge of the Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreif3pi6x3owo5ra6aluluvykc6qgb2me32wjueb7pnf2v62k2vxuay")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDC>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

