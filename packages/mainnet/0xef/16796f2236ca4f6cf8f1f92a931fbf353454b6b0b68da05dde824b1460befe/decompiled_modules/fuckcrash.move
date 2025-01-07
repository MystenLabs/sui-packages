module 0xef16796f2236ca4f6cf8f1f92a931fbf353454b6b0b68da05dde824b1460befe::fuckcrash {
    struct FUCKCRASH has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKCRASH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKCRASH>(arg0, 6, b"FUCKCRASH", b"SUI FUCK CRASH", b"FUCK CRASH", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ga_It_D_5_Xk_AASRBP_435410af4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKCRASH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUCKCRASH>>(v1);
    }

    // decompiled from Move bytecode v6
}

