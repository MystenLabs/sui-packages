module 0xcf501baf3e92f8d89bbd8820dc867131fc3f467be83bd70cddf9fcab5e5dacc2::escobar {
    struct ESCOBAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ESCOBAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ESCOBAR>(arg0, 6, b"ESCOBAR", b"Everyone Should Control On Buying All Rugs.", x"412067656e746c652072656d696e64657220746f206e6f7420746f20627579205275672e20536f6369616c73205442412e2046696e64206d65206f6e20446973636f726420696620796f752063616e2c20666f72206561726c79206163636573732e4e4f20505650204a55535420484f444c20616e64204265205249434820524943482e20696e76657374206c6f7720616e6420666f726765742069742e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020200a20202820202e2920202820202e2920535455445920544852454144532e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/96bp4x_8a625185e9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ESCOBAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ESCOBAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

