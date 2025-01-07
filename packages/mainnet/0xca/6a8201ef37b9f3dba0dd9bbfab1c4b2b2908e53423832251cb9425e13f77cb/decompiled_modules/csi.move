module 0xca6a8201ef37b9f3dba0dd9bbfab1c4b2b2908e53423832251cb9425e13f77cb::csi {
    struct CSI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSI>(arg0, 6, b"CSI", b"CSI8800", b"$CSI is not affiliated with ***China Security Index**** ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9784d3bf93d50982f65d09172614dac0_png_copy_0e14b6ed3a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSI>>(v1);
    }

    // decompiled from Move bytecode v6
}

