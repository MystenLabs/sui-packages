module 0x35216e9f24804d79f88190f9a2aa07e358d2e5d50f84606a4018863b589d6132::brainrotai {
    struct BRAINROTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINROTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINROTAI>(arg0, 6, b"BrainRotAI", b"Brain Rot AI", b"Innovation within the brain rot space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/546346_fe5e2b7757.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINROTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINROTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

