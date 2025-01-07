module 0xfc59d90097141a0d37525af6c113e9543a98992dd30ec415af695aa6db6b29e5::axoi {
    struct AXOI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXOI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AXOI>(arg0, 6, b"AxoI", b"AXOL | SUI", b"Meet AXOL, the cutest amphibian on SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_4r_M_DXUAA_Ls3e_e529aba2ed.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXOI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AXOI>>(v1);
    }

    // decompiled from Move bytecode v6
}

