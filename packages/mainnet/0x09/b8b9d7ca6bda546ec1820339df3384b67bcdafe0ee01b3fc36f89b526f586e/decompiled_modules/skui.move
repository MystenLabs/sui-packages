module 0x9b8b9d7ca6bda546ec1820339df3384b67bcdafe0ee01b3fc36f89b526f586e::skui {
    struct SKUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKUI>(arg0, 6, b"SKUI", b"SharKui", b"KUI is not just a crypto, not just a meme it a REVOLUTION", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreih3fyq4yeaslstheqzddxhwho4cs7u7opohrcola5vw6hqtmx64ui")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SKUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

