module 0x7b85bd5de0cd8a6063b325fd35d74617c95c9129f07694f70421378d7057efd1::angeltrump {
    struct ANGELTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGELTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGELTRUMP>(arg0, 6, b"AngelTrump", b"Angel Trump", b"Cute Little Angel Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/c7d91d212797089_673b7a367b1be_e211e200c8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGELTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGELTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

