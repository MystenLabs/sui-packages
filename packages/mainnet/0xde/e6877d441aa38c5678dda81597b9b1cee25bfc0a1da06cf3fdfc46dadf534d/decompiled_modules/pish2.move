module 0xdee6877d441aa38c5678dda81597b9b1cee25bfc0a1da06cf3fdfc46dadf534d::pish2 {
    struct PISH2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: PISH2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PISH2>(arg0, 6, b"PISH2", b"Pishi 2", x"41722d61722d6172212041722d61722d6172212041722d61722d6172212041722d61722d6172210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aasd_6fde259a14_a18e93771f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PISH2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PISH2>>(v1);
    }

    // decompiled from Move bytecode v6
}

