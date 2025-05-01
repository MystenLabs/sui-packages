module 0x856447ef5d7cc65ca76899df1c4a477ef6ee69465c91250894425bc7273de589::shot {
    struct SHOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHOT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHOT>(arg0, 6, b"SHOT", b"Pop Shot", b"Welcome to $POPSHOT! Join our exclusive FPS trainer genesis event. Top players win supply control after milestones are met. 1st event will be shortly after we bond from pumpfun. With winners playing a big roll in the future of the community!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jtimaa_52a9c05068.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHOT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHOT>>(v1);
    }

    // decompiled from Move bytecode v6
}

