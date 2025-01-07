module 0x8b7fff0fa3558ac3fa605e55fe14ce842a93c2a7315a1c45af05e50d01a0496::cash {
    struct CASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CASH>(arg0, 6, b"CASH", b"CATFISH", b"Step aside, frogs, dogs, and cats. Cash Token is the new community favorite! With the sleek allure of a fish and the charm of a cat, Cash Token is redefining the crypto scene. Join us and let Cash bring fun and unity to our community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_27_01_49_56_5695d458b9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

