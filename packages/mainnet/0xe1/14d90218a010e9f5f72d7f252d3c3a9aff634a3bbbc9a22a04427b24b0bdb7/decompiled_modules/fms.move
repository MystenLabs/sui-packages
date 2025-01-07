module 0xe114d90218a010e9f5f72d7f252d3c3a9aff634a3bbbc9a22a04427b24b0bdb7::fms {
    struct FMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMS>(arg0, 9, b"FMS", b"Funny Meme Sui", b"Funny meme Sui pair launch for Communty", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRN6jabvi2wualPRmWsUnnXFgjLPQKPzyQtFA&s")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FMS>(&mut v2, 480000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FMS>>(v1);
    }

    // decompiled from Move bytecode v6
}

