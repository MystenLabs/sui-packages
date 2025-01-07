module 0x50c5b494e05ea69bfc78996f7bf1ff42eda585647e5352cc8b6c28ec169e31f4::sreddit {
    struct SREDDIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SREDDIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SREDDIT>(arg0, 6, b"SREDDIT", b"SUI REDDIT", b"Reddit on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3783_ad01407594.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SREDDIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SREDDIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

