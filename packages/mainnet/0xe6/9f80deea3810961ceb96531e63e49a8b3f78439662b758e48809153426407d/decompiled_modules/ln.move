module 0xe69f80deea3810961ceb96531e63e49a8b3f78439662b758e48809153426407d::ln {
    struct LN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LN>(arg0, 5, b"Ln", b"7E7", b"Creator Ave immutable owner of qD~sps~qT~caac tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://photos.app.goo.gl/AsE5Q1TfzxKhYAXV7")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LN>(&mut v2, 7700000000000700000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LN>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LN>>(v1);
    }

    // decompiled from Move bytecode v6
}

