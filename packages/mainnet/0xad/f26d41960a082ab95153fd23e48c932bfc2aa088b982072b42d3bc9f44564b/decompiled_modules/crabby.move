module 0xadf26d41960a082ab95153fd23e48c932bfc2aa088b982072b42d3bc9f44564b::crabby {
    struct CRABBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRABBY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRABBY>(arg0, 6, b"Crabby", b"Crabby on SUI", b"Matt Furies art fuels Crabby, the Sui-exclusive memecoin launching on Movepump! More than a token, were a vibrant community driven by art and blockchain innovation. Join our Crabby crew on Sui  lets scuttle to the moon!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/crab_logo_01_07b0a5f71a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRABBY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRABBY>>(v1);
    }

    // decompiled from Move bytecode v6
}

