module 0x4a103ddc730e62e8495f9a389e24ceb34e3b089187a2e2efea1f85e7df6d9210::blub {
    struct BLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUB>(arg0, 6, b"BLUB", b"Blub", b"Blubiest fish on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUB_273f8efbac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUB>>(v1);
    }

    // decompiled from Move bytecode v6
}

