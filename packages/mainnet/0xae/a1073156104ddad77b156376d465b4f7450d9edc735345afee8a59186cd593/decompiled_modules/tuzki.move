module 0xaea1073156104ddad77b156376d465b4f7450d9edc735345afee8a59186cd593::tuzki {
    struct TUZKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUZKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUZKI>(arg0, 6, b"Tuzki", b"Tuzki The Sticker", b"Tuzki is a popular illustrated bunny character created by animator Momo Wang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreig5zpyawebsv6hpyprtufesfoqwzcwrffql67gmhefujaislrt6qu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUZKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TUZKI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

