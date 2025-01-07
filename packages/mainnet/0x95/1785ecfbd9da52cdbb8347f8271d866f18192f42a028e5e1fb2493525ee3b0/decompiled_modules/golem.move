module 0x951785ecfbd9da52cdbb8347f8271d866f18192f42a028e5e1fb2493525ee3b0::golem {
    struct GOLEM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOLEM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOLEM>(arg0, 6, b"GOLEM", b"SuiGOLEM", b"Get ready to meme your way to the moon with our crypto craziness! No FOMO, just fun!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/qa_DVLM_Oa_400x400_5a6bafccb6_71adad97e5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOLEM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GOLEM>>(v1);
    }

    // decompiled from Move bytecode v6
}

