module 0xa7cfc7823d9876e62aa797a42736c9d3427e3039f09024b730d767d99394be4f::tako {
    struct TAKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAKO>(arg0, 9, b"Tako", b"Takoku", b"This is a coin meme just for entertainment, especially for those who haven't got Tako NFT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/152070914f3dc6db13121b2af45bb9ebblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAKO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAKO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

