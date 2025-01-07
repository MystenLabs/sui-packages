module 0x8cc1d60a7636476cf103841cceb4bb3099c87fcf27ff858a602ea281617ff9a0::babyneiro {
    struct BABYNEIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYNEIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYNEIRO>(arg0, 6, b"BABYNEIRO", b"Baby Neiro on sui", b"BABY is the ultimate Tear Drop who can do it all! With his iconic mustache and boundless charm, he embodies the spirit of the SUI chaincreativity, community, and endless fun. BABY is the heartbeat of our vibrant ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20240923_082737_3227f3f64c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYNEIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYNEIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

