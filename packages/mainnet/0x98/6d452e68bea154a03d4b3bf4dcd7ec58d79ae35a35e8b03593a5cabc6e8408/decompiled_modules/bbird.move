module 0x986d452e68bea154a03d4b3bf4dcd7ec58d79ae35a35e8b03593a5cabc6e8408::bbird {
    struct BBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBIRD>(arg0, 6, b"BBIRD", b"BlueBird On Sui", b"The King of Sui Meme Coins. Flying Higher Than Gas Fees!\"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeicww2ym52pkgyx6rzqftrbtlgsveaqojxwmzihyxjmyru5lowrkea")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BBIRD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

