module 0x7131657aed24b910fffcddbe804ad4b94765397b269c075810fd08d5dce8cb5a::puffing {
    struct PUFFING has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUFFING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUFFING>(arg0, 6, b"Puffing", b"PuffingSUI", b"Join the wave of the future with PufferSUI and experience the buoyancy of financial freedom.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GY_Zg_Tsd_Xk_AA_Elec_fe2698e66c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUFFING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUFFING>>(v1);
    }

    // decompiled from Move bytecode v6
}

