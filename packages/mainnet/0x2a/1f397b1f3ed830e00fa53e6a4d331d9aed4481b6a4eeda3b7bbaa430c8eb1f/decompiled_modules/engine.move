module 0x2a1f397b1f3ed830e00fa53e6a4d331d9aed4481b6a4eeda3b7bbaa430c8eb1f::engine {
    struct ENGINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ENGINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ENGINE>(arg0, 6, b"ENGINE", b"Conductor Eric", x"436f6e647563746f7220457269632064726976657320746865206d6f6e657920747261696e2e20486520686173206d6f72652063617368207468616e2068652063616e207370656e642c20627574206973207374696c6c2067656e65726f757320616e64206b696e642e20416e642068697320667269656e647320617265206120747269702e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qm_Vxijz8_B_Hj_FAX_4_You_Y_Eayh4_Gth_H_Po_Bip_Td7_M1_Dft_V42_LQ_30c2f9db67.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ENGINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ENGINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

