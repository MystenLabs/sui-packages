module 0x7437757361ff5fea3b85a72035de5d67fd238c98fe6c6bc64431721c4d20c79a::sdfsdwe {
    struct SDFSDWE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSDWE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSDWE>(arg0, 1, b"SDFSDWE", b"SDF", b"WER", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDFSDWE>(&mut v2, 90000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSDWE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFSDWE>>(v1);
    }

    // decompiled from Move bytecode v6
}

