module 0x51bf37bf6c8cb17332bee141984eabb7275438e06d81a0d4e4e43c02fdf9c959::tpel {
    struct TPEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPEL>(arg0, 6, b"TPEL", b"TURBO PELICAN", b"Gliding through the crypto skies at turbo speed. This pelican is on a mission to deliver gains", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_19_030518111_81b72b82e7.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TPEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

