module 0x7a31b83c0cf16b3703d19f9a1a2e1c3ac9034b5921ba22810bf7b271e02099f9::PONKE {
    struct PONKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PONKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PONKE>(arg0, 9, b"PONKE", b"PONKE", b"$PONKE proudly joins the elite.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1738717393617129472/9kWt-aOf_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PONKE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PONKE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<PONKE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PONKE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

