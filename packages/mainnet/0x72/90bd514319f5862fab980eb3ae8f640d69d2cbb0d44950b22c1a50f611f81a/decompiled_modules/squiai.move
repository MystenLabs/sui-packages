module 0x7290bd514319f5862fab980eb3ae8f640d69d2cbb0d44950b22c1a50f611f81a::squiai {
    struct SQUIAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SQUIAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SQUIAI>(arg0, 6, b"SQUIAI", b"SQUI AI", b"$SQUI is the cutest mollusc to ever grace the depths of the $Sui ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Vo12_HO_Vg_400x400_733530bc7c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SQUIAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SQUIAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

