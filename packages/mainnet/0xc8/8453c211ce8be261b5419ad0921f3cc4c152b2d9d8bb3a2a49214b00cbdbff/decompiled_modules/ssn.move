module 0xc88453c211ce8be261b5419ad0921f3cc4c152b2d9d8bb3a2a49214b00cbdbff::ssn {
    struct SSN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSN>(arg0, 6, b"SSN", b"Sui Satoshi Nakamoto", b"Satoshi Nakamoto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_08_18_42_03_2_629b6a09be.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSN>>(v1);
    }

    // decompiled from Move bytecode v6
}

