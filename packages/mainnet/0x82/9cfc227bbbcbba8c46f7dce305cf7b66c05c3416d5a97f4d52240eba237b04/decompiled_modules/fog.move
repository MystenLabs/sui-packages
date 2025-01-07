module 0x829cfc227bbbcbba8c46f7dce305cf7b66c05c3416d5a97f4d52240eba237b04::fog {
    struct FOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOG>(arg0, 6, b"Fog", b"Sui Fog", b"Fog just a cute little green buddy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/79_A93947_825_A_42_DF_A2_A3_A8_F05_BC_34155_7152e58b73.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

