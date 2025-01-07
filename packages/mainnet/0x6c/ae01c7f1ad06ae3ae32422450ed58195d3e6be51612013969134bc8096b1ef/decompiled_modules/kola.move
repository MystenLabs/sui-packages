module 0x6cae01c7f1ad06ae3ae32422450ed58195d3e6be51612013969134bc8096b1ef::kola {
    struct KOLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLA>(arg0, 6, b"KOLA", b"kola is the future", b"Kola on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://hotpot.ai/images/site/ai/photoshoot/avatar/style_gallery/38.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOLA>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

