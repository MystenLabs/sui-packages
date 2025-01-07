module 0xe7610bcaa6b0693496a348337132c26daab78f6b618763e98359eca2cfe09bba::menalia {
    struct MENALIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MENALIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MENALIA>(arg0, 6, b"MENALIA", b"MENALIA SUI", b"tremp 4 maga", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_23_37_55_11e3118140.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MENALIA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MENALIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

