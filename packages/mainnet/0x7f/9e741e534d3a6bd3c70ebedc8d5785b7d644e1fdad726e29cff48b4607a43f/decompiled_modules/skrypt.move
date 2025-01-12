module 0x7f9e741e534d3a6bd3c70ebedc8d5785b7d644e1fdad726e29cff48b4607a43f::skrypt {
    struct SKRYPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKRYPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKRYPT>(arg0, 9, b"SKRYPT", b"SKRYPT on SUI", b"Skrypt is an advanced AI text generator that revolutionizes content creation. From compelling articles to creative stories and marketing materials, Skrypt delivers high-quality, human-like text tailored to your needs. Save time, enhance efficiency, and unlock new possibilities in writing with Skryptthe engine behind your next great idea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmQEajVqLS6TgHXhBdQgWrGnJEC4wnL4kzDKYTshLyh5f1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SKRYPT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SKRYPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKRYPT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

