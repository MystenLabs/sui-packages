module 0xbbfb1283676220995fb5ec7308661123d463290f90255b7b47c12a32d62a82ef::puffle {
    struct PUFFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFLE>(arg0, 6, b"PUFFLE", b"PUFFLE ON SUI", x"0a507566666c6520697320746865206c6174657374206d656d65636f696e206c61756e63686564206f6e207468652053756920626c6f636b636861696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_19_11_27_52_462205e520.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

