module 0xa34d6b2eed809871def9418118739b970d9bdbe14f29e1a540fdedbcd1d57c51::extinct {
    struct EXTINCT has drop {
        dummy_field: bool,
    }

    fun init(arg0: EXTINCT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EXTINCT>(arg0, 9, b"extinct", b"Extinct", b"Sui Extinct Sports", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.dribbble.com/userupload/16999423/file/original-17623ff5a1b5f1f713a9acfef44a54fe.png?resize=1024x768")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EXTINCT>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EXTINCT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EXTINCT>>(v1);
    }

    // decompiled from Move bytecode v6
}

