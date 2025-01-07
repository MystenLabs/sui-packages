module 0x7713259fdfbd9005a4ad9fcf2a4930ee7fbac3cc6a9b6d34862a2c53b2855ec1::smash {
    struct SMASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMASH>(arg0, 6, b"SMASH", b"Sui Smash Bros", b"Ready, Set, Smash! Your Journey on SUI Awaits with Smash Bros!  Try our beta arcade", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y_Rvmf_Nv_A_400x400_e99b657448.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SMASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

