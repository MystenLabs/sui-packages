module 0x40a12644b307bd6e6239f7366272d60177a6b92863eb99dad29f7ea57bf47910::aaaduck {
    struct AAADUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAADUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAADUCK>(arg0, 6, b"AAADUCK", b"aaaDuck", b"can't stop won't stop (Loving Sui)", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_2e78af4a3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAADUCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAADUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

