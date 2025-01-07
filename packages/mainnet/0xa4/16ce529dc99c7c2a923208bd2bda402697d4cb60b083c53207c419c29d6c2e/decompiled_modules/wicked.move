module 0xa416ce529dc99c7c2a923208bd2bda402697d4cb60b083c53207c419c29d6c2e::wicked {
    struct WICKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: WICKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WICKED>(arg0, 6, b"WICKED", b"Wicked Ai", b"AI reimagining of the Wicked universe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000049156_b7b497ef30.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WICKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WICKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

