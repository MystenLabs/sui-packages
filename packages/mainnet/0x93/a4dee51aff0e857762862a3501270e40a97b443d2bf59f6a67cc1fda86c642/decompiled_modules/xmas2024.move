module 0x93a4dee51aff0e857762862a3501270e40a97b443d2bf59f6a67cc1fda86c642::xmas2024 {
    struct XMAS2024 has drop {
        dummy_field: bool,
    }

    fun init(arg0: XMAS2024, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<XMAS2024>(arg0, 6, b"XMAS2024", b"Xmas 2024 on SUI", b"Spreading holiday cheer one memecoin at a time.  Join the Xmas crypto craze  where the only thing colder than the snow is the price! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ir_Ud_J_6l_400x400_1_c7089c20e8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XMAS2024>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XMAS2024>>(v1);
    }

    // decompiled from Move bytecode v6
}

