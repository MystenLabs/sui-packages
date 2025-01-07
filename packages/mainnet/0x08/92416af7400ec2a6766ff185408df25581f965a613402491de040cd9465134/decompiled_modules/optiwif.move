module 0x892416af7400ec2a6766ff185408df25581f965a613402491de040cd9465134::optiwif {
    struct OPTIWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OPTIWIF>(arg0, 6, b"OPTIWIF", b"Optimus Wif Hat", b"Robo Wif Hat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/X6_T3pymy_EG_8_Zd79_M1pf9c_DE_2x_Qhjnijm5_Fn4s_C2pump_04e4f15109.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTIWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

