module 0x353b1c78e398f5a5f4d51f1fd7f9b60f7e00cefd82b0324104c675afd7cddb2b::downshat {
    struct DOWNSHAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOWNSHAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOWNSHAT>(arg0, 6, b"DOWNSHAT", b"PUGTATO WIF HAT", x"504f5441544f455320414e4420594f55204841564520534f4d455448494e4720494e20434f4d4d4f4e20594f55204558545241204348524f4d4f534f4d45204341525259494e47204655434b2e200a0a4f6e6c7920796f7520646f6e277420686176652061206861742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/pugtato_ec45bf2b13.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOWNSHAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOWNSHAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

