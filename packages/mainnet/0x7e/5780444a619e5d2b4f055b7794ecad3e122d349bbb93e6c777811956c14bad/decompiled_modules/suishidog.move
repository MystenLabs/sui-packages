module 0x7e5780444a619e5d2b4f055b7794ecad3e122d349bbb93e6c777811956c14bad::suishidog {
    struct SUISHIDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHIDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHIDOG>(arg0, 6, b"SUISHIDOG", b"suishi dog", x"7375697368756920646f672e0a0a68747470733a2f2f742e6d652f737569736869646f67", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_6_86a81d7edf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHIDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHIDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

