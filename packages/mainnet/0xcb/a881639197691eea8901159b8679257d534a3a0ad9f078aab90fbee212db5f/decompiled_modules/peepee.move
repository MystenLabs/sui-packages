module 0xcba881639197691eea8901159b8679257d534a3a0ad9f078aab90fbee212db5f::peepee {
    struct PEEPEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEEPEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEEPEE>(arg0, 6, b"PEEPEE", b"Peepee Pig", b"Hello ! My name is Peepee Pig !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000044028_f2a71bd50d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEEPEE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEEPEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

