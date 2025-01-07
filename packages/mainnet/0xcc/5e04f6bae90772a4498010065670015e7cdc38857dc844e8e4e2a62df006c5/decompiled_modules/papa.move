module 0xcc5e04f6bae90772a4498010065670015e7cdc38857dc844e8e4e2a62df006c5::papa {
    struct PAPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPA>(arg0, 6, b"Papa", b"Papa on sui", b"Meet papa, the mastermind ready to dominate the Sui blockchain scene. With street-smart strategy and unmatched influence, papa's about to take over and set new rules in the game of innovation and leadership.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034898_0a28aa21a1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

