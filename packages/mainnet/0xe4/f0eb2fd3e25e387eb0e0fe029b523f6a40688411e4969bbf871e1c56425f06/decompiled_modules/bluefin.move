module 0xe4f0eb2fd3e25e387eb0e0fe029b523f6a40688411e4969bbf871e1c56425f06::bluefin {
    struct BLUEFIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEFIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEFIN>(arg0, 6, b"blueFIN", b"RETARDIO HOLDING THE FIN", b"HODLING THE blueFIN from the sui waters", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Vr_B30d_Xw_A_Ab1_P2_0cdbe8d7a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEFIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEFIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

