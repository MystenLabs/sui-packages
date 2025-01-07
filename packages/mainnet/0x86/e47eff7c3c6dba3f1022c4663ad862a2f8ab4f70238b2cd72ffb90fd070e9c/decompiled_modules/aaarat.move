module 0x86e47eff7c3c6dba3f1022c4663ad862a2f8ab4f70238b2cd72ffb90fd070e9c::aaarat {
    struct AAARAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAARAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAARAT>(arg0, 6, b"AAARAT", b"SUI RATS", b"SUI RATS HERE HOLD YOUR BAGS TO THE MOON", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_27_03_04_01_0ebd855dad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAARAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAARAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

