module 0x39c66201f9c2ed032e171b8e588364bf7a760a36b90dc212464ee5d747eb7fb::ok {
    struct OK has drop {
        dummy_field: bool,
    }

    fun init(arg0: OK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::option::none<0x2::url::Url>();
        0x1::option::fill<0x2::url::Url>(&mut v0, 0x2::url::new_unsafe_from_bytes(b"https://cryptologos.cc/sui"));
        let (v1, v2) = 0x2::coin::create_currency<OK>(arg0, 6, b"OK", b"Ok", b"", v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OK>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OK>>(v2);
    }

    public entry fun renounce_ownership(arg0: 0x2::coin::TreasuryCap<OK>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<OK>>(arg0);
    }

    // decompiled from Move bytecode v6
}

