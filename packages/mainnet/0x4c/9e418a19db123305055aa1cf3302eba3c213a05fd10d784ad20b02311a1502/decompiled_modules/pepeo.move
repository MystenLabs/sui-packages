module 0x4c9e418a19db123305055aa1cf3302eba3c213a05fd10d784ad20b02311a1502::pepeo {
    struct PEPEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPEO>(arg0, 6, b"PEPEO", b"Pepeo", x"506570656f207365657320746865206675747572652e204265636f6d65206120686f6c6465722020646973636f76657220776861742061776169747320796f752e0a0a426173656420696e2054656c656772616d204d696e692041707020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8225_4b37d74980.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPEO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPEO>>(v1);
    }

    // decompiled from Move bytecode v6
}

