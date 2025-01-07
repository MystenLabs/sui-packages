module 0x61db075c69b747b91c4f283e029292dd699d295fe99879e2737d847dd2028514::trumpy {
    struct TRUMPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPY>(arg0, 6, b"Trumpy", b"Trumpy no Dumpy", b"Trumpy no dumpy. Only pumpy. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/67797_FCB_797_B_4411_B908_4_ADC_2_FCFC_13_B_0858063670.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TRUMPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

