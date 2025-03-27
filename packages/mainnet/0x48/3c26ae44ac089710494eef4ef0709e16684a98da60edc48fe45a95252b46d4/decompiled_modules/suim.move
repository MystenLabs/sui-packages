module 0x483c26ae44ac089710494eef4ef0709e16684a98da60edc48fe45a95252b46d4::suim {
    struct SUIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIM>(arg0, 6, b"SUIM", b"SUIMEN", x"496620497420446f65736e2774205461737465204c696b6520245355494d454e2c2049276d204e6f7420427579696e672049742e203a330a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_11_04_56_07_2_b29666f893_3d4ce24c9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

