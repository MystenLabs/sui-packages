module 0x1c6f3946a7eef746534424e42bc72c5a1eeaa3adb0a7515281db6de9d34792e9::toma {
    struct TOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMA>(arg0, 6, b"TOMA", b"Tomarket On Sui", b"Official Tomarket Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000213766_1408f4c276.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

