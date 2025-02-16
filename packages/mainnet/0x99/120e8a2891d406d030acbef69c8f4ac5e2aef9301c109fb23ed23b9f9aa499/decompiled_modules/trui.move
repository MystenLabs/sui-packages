module 0x99120e8a2891d406d030acbef69c8f4ac5e2aef9301c109fb23ed23b9f9aa499::trui {
    struct TRUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUI>(arg0, 6, b"TRUI", b"TRY PEPE", b"First Thread Embroidery Pepe on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/9_F5_EC_54_D_34_DA_48_BE_818_B_C877_ACA_0_DBF_8_8006a5c429.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

