module 0x4e64cd5987c369b5ba3455b9428ba488ee77c9a2a4e61943a111ce6d172b7275::yui {
    struct YUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YUI>(arg0, 9, b"YUI", b"yui", b"yuiyuiyuiyui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

