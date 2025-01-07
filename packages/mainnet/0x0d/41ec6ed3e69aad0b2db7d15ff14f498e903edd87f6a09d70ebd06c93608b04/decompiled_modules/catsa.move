module 0xd41ec6ed3e69aad0b2db7d15ff14f498e903edd87f6a09d70ebd06c93608b04::catsa {
    struct CATSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATSA>(arg0, 6, b"CATSA", b"Cat Sakamoto", x"4361742053616b616d6f746f20697320612062656c6f766564206368617261637465722066726f6d20746865204a6170616e657365206d616e6761207365726965732c204e696368696a6f752e0a0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/catclub_cee4aa27cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

