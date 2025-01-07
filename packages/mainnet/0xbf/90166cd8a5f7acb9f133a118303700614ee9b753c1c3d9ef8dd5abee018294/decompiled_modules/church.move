module 0xbf90166cd8a5f7acb9f133a118303700614ee9b753c1c3d9ef8dd5abee018294::church {
    struct CHURCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHURCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHURCH>(arg0, 6, b"CHURCH", b"ATH", b"ATH.CHURCH stands firm against Transhumanism, teaching believers to reject the idolatry of technology and trust in Gods perfect design. The Church governance is on-chain with integrated operational technologies.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pa_XD_Xk_SF_400x400_3dd74fce5c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHURCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHURCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

