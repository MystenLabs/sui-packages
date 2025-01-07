module 0x80697b66b79f3c200ac87b75683293eb9e3170c5aed0f0b630abad522a31f0bd::suisen {
    struct SUISEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEN>(arg0, 6, b"SUISEN", b"Sui Sensei", x"486170707920746f20736565205355492067657474696e6720746865207265737065637420616e64207265636f676e6974696f6e207468657920646573657276652e20496d2062756c6c6973682061662e0a0a4e6f7720746861742061207374726f6e6720636f6d6d756e69747920686173206265656e20666f726d65642c20492077696c6c2074727920746f206265206d6f72652061637469766520686572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_2t_Cy0_XM_Ao7_Sp_G_fe0ca55b14.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

