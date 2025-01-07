module 0xb59ec11244297f16f28b98e7b07d0df7c6278651a52ac1635974880139d4b28b::guosui {
    struct GUOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUOSUI>(arg0, 6, b"GUOSUI", b"GUO SUI", b"The original chinese dog. Now at Sui ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/460630831_1291530722015940_7208676263108271562_n_84505e7c83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GUOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

