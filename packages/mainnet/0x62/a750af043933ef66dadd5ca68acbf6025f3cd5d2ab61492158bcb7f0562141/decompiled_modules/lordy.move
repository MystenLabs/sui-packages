module 0x62a750af043933ef66dadd5ca68acbf6025f3cd5d2ab61492158bcb7f0562141::lordy {
    struct LORDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: LORDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LORDY>(arg0, 6, b"LORDY", b"FIRSR LORDY ON SUI", b"PUMP IT LIKE LORDY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_23_55f6dc942d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LORDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LORDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

