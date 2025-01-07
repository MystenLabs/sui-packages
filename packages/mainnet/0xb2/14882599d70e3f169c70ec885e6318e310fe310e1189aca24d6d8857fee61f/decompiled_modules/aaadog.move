module 0xb214882599d70e3f169c70ec885e6318e310fe310e1189aca24d6d8857fee61f::aaadog {
    struct AAADOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADOG>(arg0, 6, b"aaaDOG", b"aaa dog", b"Can't stop won't stop (thinking about Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20240915114320_b7d9763c0a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

