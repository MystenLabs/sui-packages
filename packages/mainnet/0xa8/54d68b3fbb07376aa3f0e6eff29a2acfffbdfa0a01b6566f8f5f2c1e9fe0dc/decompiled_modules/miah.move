module 0xa854d68b3fbb07376aa3f0e6eff29a2acfffbdfa0a01b6566f8f5f2c1e9fe0dc::miah {
    struct MIAH has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIAH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIAH>(arg0, 6, b"MIAH", b"Test Project on SUI", b"This project is testing how movepump works on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ltc2f35_fbfd4a27fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIAH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MIAH>>(v1);
    }

    // decompiled from Move bytecode v6
}

