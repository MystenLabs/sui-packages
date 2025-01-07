module 0x72c7f2a64bf113bb6b3bfb26f9db787c101a9f05be82c9270fff477d90b87178::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGGO>(arg0, 6, b"DOGGO", b"SuiDoggo", b"SuiDoggo is the next big meme token, combining Doges viral power with Suis blazing-fast blockchain to deliver unmatched rewards. With its playful ecosystem and growing community, SuiDoggo is set to dominate the meme coin market!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/A9_DF_6_DD_7_25_A8_472_F_AD_1_F_68_D352137831_2de09298dd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

