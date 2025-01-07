module 0x924847e7fc1a933a6dd7183beb17271795036258fc7c8a359de3b28ce01a85e7::suilami {
    struct SUILAMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILAMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILAMI>(arg0, 6, b"SUILAMI", b"Suilami on sui", b"$SUILAMI on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000000419_37476cae89.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILAMI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILAMI>>(v1);
    }

    // decompiled from Move bytecode v6
}

