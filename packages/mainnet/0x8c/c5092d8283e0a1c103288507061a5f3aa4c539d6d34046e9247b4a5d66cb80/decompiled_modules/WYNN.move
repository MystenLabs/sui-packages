module 0x8cc5092d8283e0a1c103288507061a5f3aa4c539d6d34046e9247b4a5d66cb80::WYNN {
    struct WYNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WYNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WYNN>(arg0, 9, b"WYNN", b"Anita Max Wynn", b"Ladies with gentle hands this is my alter ego. $WYNN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1742660672125554688/6TPl-mS4_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WYNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WYNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<WYNN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<WYNN>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

