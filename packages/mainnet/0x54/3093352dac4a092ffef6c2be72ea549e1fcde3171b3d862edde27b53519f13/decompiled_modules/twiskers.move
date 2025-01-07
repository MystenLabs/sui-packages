module 0x543093352dac4a092ffef6c2be72ea549e1fcde3171b3d862edde27b53519f13::twiskers {
    struct TWISKERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TWISKERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TWISKERS>(arg0, 6, b"TWISKERS", b"First Twiskers On Sui", b"Better watch out, cause Im here to conquer all the memes with my fluff and claws, nya! Beware of fake contracts !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/flag_d37ff44d15.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TWISKERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TWISKERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

