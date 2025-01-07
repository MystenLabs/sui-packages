module 0x1ce1665df3ba37f30ff47a53bfa3f3c17d6b8c5933ed0512ae974090a027984f::kermit {
    struct KERMIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMIT>(arg0, 9, b"KERMIT", b"Kermit On Sui", b"kermit is meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844387261472964609/g-wT6PpF.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KERMIT>(&mut v2, 500000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMIT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KERMIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

