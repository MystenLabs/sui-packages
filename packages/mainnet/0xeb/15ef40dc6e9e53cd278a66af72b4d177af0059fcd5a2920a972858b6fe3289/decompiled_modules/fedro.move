module 0xeb15ef40dc6e9e53cd278a66af72b4d177af0059fcd5a2920a972858b6fe3289::fedro {
    struct FEDRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: FEDRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FEDRO>(arg0, 6, b"FEDRO", b"FEDORO69", b"FEDORO MACHINE 69", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Pzhzd_Wc_A_Ah_N_Nr_371b784ecc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FEDRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FEDRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

