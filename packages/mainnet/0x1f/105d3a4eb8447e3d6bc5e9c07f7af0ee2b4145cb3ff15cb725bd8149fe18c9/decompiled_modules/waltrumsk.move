module 0x1f105d3a4eb8447e3d6bc5e9c07f7af0ee2b4145cb3ff15cb725bd8149fe18c9::waltrumsk {
    struct WALTRUMSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: WALTRUMSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WALTRUMSK>(arg0, 9, b"Waltrumsk", b"WaryTRumpElonmusk", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/d6aea46c2034d5fb686a5e4a9f4a5644blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WALTRUMSK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WALTRUMSK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

