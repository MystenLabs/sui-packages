module 0x62a60daa58d821fb58bb586f6218ce8513b9a60cce185387d393664eedc4a59b::monsui {
    struct MONSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONSUI>(arg0, 6, b"MonSui", b"MonSui Storm", b"MonSui is the ultimate SUI powered meme token, and were here to make waves in the crypto world. Our goal? To take each MonSui token to $1 and beyond!  Join the community as we ride the currents of the crypto market, share the hottest takes, and have a blast along the way. No FUD, just stormy vibes and big dreams!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_1_e3086706a3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

