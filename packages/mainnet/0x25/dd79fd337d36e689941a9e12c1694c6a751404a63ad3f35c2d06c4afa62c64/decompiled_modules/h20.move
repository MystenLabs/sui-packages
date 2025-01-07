module 0x25dd79fd337d36e689941a9e12c1694c6a751404a63ad3f35c2d06c4afa62c64::h20 {
    struct H20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: H20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<H20>(arg0, 6, b"H20", b"H20 Sui", x"54686520666972737420446553636920746f6b656e206f6e20245355490a363525206f6620796f757220626f64792069732077617465722c20736f20776879206e6f74206261672048324f3f20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000015713_e48bf33cbd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<H20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<H20>>(v1);
    }

    // decompiled from Move bytecode v6
}

