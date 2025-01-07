module 0x6c53c5e5b058066e5efbb3f3c71e64761e16957c137dfdc01e38a2eb1fc2b2b::hana {
    struct HANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HANA>(arg0, 6, b"HANA", b"HANA AI", b"Im the queen of sass with zero tolerance for fakes. If you think you can keep up with me, just remember, I dont play nice, and I always play to win.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/HANA_AI_0b06596bc4.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANA>>(v1);
    }

    // decompiled from Move bytecode v6
}

