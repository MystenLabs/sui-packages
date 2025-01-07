module 0x769c47aac9dfe5ea6e19d5866b13dc9fd63734be2d8387ec04b805fd8eb3e8d::ssn {
    struct SSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSN>(arg0, 6, b"SSN", b"SUISANOO", b"Suisanoo enter Blockchain World", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/938e609e_9b43_480e_9f6a_69b6dee9beb0_0020f51610.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

