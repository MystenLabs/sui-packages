module 0x9d15046f6618862039e1d27b74f827596c94330f91272c5f438334119106eb3e::the47 {
    struct THE47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: THE47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<THE47>(arg0, 6, b"THE47", b"NEXT PRESIDENT OF AMERICA", b"THE 47TH PRESIDENT OF USA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/47thpresiden_1b632a8fef.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THE47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THE47>>(v1);
    }

    // decompiled from Move bytecode v6
}

