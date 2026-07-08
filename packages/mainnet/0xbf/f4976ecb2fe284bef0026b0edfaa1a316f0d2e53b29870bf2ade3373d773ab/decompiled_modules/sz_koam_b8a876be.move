module 0xbff4976ecb2fe284bef0026b0edfaa1a316f0d2e53b29870bf2ade3373d773ab::sz_koam_b8a876be {
    struct SZ_KOAM_B8A876BE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SZ_KOAM_B8A876BE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SZ_KOAM_B8A876BE>(arg0, 9, b"KOAM", b"Koala Mint", b"Koala Mint is a signal-boosted meme token channeling ape hype for Reddit threads, tipping, and quick raids.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.slingzero.com/images/ai-logos/koala-mint.webp")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::Coin<SZ_KOAM_B8A876BE>>(0x2::coin::mint<SZ_KOAM_B8A876BE>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SZ_KOAM_B8A876BE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SZ_KOAM_B8A876BE>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

