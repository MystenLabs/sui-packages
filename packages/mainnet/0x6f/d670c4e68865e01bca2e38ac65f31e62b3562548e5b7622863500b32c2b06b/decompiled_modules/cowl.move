module 0x6fd670c4e68865e01bca2e38ac65f31e62b3562548e5b7622863500b32c2b06b::cowl {
    struct COWL has drop {
        dummy_field: bool,
    }

    fun init(arg0: COWL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COWL>(arg0, 9, b"COWL", b"Cow Link", b"Cow Link is a raid-ready meme token channeling cat memes for TikTok clips, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/QmdWBfcKe8BGwi281eUvrXm2mztCZ86XWJdZC7V7UdmhjU")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<COWL>>(0x2::coin::mint<COWL>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COWL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COWL>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

