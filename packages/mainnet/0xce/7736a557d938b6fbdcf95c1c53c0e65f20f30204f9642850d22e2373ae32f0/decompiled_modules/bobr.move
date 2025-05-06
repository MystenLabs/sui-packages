module 0xce7736a557d938b6fbdcf95c1c53c0e65f20f30204f9642850d22e2373ae32f0::bobr {
    struct BOBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBR>(arg0, 6, b"BOBR", b"Bobr", b"Dive into the world of Based $BOBR  a vibrant, utility-driven memecoin built on SUI . With NFTs, an airdrop toolkit, and a builder-powered community, were creating a safer, more exciting ecosystem for everyone.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/bobr_perifl_9d6cdaf8a8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBR>>(v1);
    }

    // decompiled from Move bytecode v6
}

