module 0x712502d04655b9e71c57898fa0345fc84476fe8ef4f5aa89d9ad7d7693a2d2a::apaw {
    struct APAW has drop {
        dummy_field: bool,
    }

    fun init(arg0: APAW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APAW>(arg0, 6, b"APAW", b"meow on sui", b"the meow on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/GZ_o_N_Ih_X0_AA_Mj_PV_6492ae9d60.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APAW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APAW>>(v1);
    }

    // decompiled from Move bytecode v6
}

