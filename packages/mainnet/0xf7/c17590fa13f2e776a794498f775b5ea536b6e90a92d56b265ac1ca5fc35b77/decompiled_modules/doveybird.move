module 0xf7c17590fa13f2e776a794498f775b5ea536b6e90a92d56b265ac1ca5fc35b77::doveybird {
    struct DOVEYBIRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOVEYBIRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOVEYBIRD>(arg0, 6, b"Doveybird", b"Lovey Dovey", b"Lovey Dovey Token Inspired by Sheldons bond with a bird, Lovey Dovey Token brings quirky connections to the blockchain. Join the flock!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G_Zx_Fjc2_XMA_In_Ut_N_b23d85c534.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOVEYBIRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOVEYBIRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

