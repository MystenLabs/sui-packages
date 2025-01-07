module 0x5ba968c53223eeaab5118bd357af3334ceec644c2da22536be62812999b4b551::whaly {
    struct WHALY has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALY>(arg0, 6, b"WHALY", b"Sui Whaly", b"Meet Whaly, the boss of all SUI ocean creatures. As the leader of the digital seas, Whaly ensures safe and smooth sailing across the blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_10_09_T190536_127_9cd97605ad.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALY>>(v1);
    }

    // decompiled from Move bytecode v6
}

