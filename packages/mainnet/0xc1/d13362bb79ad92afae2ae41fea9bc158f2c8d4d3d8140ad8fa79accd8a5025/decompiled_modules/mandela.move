module 0xc1d13362bb79ad92afae2ae41fea9bc158f2c8d4d3d8140ad8fa79accd8a5025::mandela {
    struct MANDELA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANDELA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANDELA>(arg0, 6, b"MANDELA", b"Mandela", b"Join the Freedom Movement. This is History in the Making!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_01_18_17_06_28_63f1e25d00.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANDELA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANDELA>>(v1);
    }

    // decompiled from Move bytecode v6
}

