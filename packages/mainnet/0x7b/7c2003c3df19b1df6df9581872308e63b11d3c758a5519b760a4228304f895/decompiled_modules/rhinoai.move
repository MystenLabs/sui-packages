module 0x7b7c2003c3df19b1df6df9581872308e63b11d3c758a5519b760a4228304f895::rhinoai {
    struct RHINOAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RHINOAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RHINOAI>(arg0, 6, b"RhinoAi", b"Rhino AI Sui", b"Feeling bullish? Lets stampede the crypto market together!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_323b4c700e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RHINOAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RHINOAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

