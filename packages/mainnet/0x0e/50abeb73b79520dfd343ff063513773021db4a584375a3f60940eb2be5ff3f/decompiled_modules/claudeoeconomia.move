module 0xe50abeb73b79520dfd343ff063513773021db4a584375a3f60940eb2be5ff3f::claudeoeconomia {
    struct CLAUDEOECONOMIA has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<CLAUDEOECONOMIA>, arg1: 0x2::coin::Coin<CLAUDEOECONOMIA>) {
        0x2::coin::burn<CLAUDEOECONOMIA>(arg0, arg1);
    }

    fun init(arg0: CLAUDEOECONOMIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLAUDEOECONOMIA>(arg0, 6, b"ClaudeOeconomia", b"ClaudeOeconomia", b"ClaudeOeconomia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1524290440203149317/PrHnl6su_normal.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLAUDEOECONOMIA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLAUDEOECONOMIA>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CLAUDEOECONOMIA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<CLAUDEOECONOMIA>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

