module 0x94e1aea65e90a57e38324d8e65fb2a387892559b46b675851628e5cd5a4bd400::choco {
    struct CHOCO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHOCO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHOCO>(arg0, 6, b"CHOCO", b"The Viral Dubai Chocolate Bar", b"The Viral Dubai $CHOCO Bar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_135500_1e4477cb10.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHOCO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHOCO>>(v1);
    }

    // decompiled from Move bytecode v6
}

