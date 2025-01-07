module 0x5e1643e451abf38ee4160e75018b1ad3a24974e4a8f7a9118e83ea98012fa5fb::gems {
    struct GEMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GEMS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GEMS>(arg0, 0, b"GEMS", b"Gems", b"Accumulate Gems to unlock rewards in the DSL ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://shdw-drive.genesysgo.net/BpJJEY3UBobdCdUUhLK5LV9s5PT5dzAW1o9FFkzaVdBJ/gem_icon.png")), arg1);
        let v2 = v0;
        let (v3, v4) = 0x2::token::new_policy<GEMS>(&v2, arg1);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GEMS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GEMS>>(v2, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::token::TokenPolicyCap<GEMS>>(v4, 0x2::tx_context::sender(arg1));
        0x2::token::share_policy<GEMS>(v3);
    }

    // decompiled from Move bytecode v6
}

