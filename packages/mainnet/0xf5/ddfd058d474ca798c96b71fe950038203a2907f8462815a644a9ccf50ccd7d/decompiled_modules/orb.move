module 0xf5ddfd058d474ca798c96b71fe950038203a2907f8462815a644a9ccf50ccd7d::orb {
    struct ORB has drop {
        dummy_field: bool,
    }

    fun init(arg0: ORB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ORB>(arg0, 6, b"ORB", b"Pondering Orb", b"Welcome to our cult  time to begin pondering the orb. Ask the AI orb any question, the longer one ponders the wiser thy become. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/B_Yrz8_DJN_400x400_d270258862.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ORB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ORB>>(v1);
    }

    // decompiled from Move bytecode v6
}

