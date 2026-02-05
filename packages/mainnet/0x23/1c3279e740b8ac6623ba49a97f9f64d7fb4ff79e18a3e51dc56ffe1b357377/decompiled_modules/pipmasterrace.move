module 0x231c3279e740b8ac6623ba49a97f9f64d7fb4ff79e18a3e51dc56ffe1b357377::pipmasterrace {
    struct PIPMASTERRACE has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<PIPMASTERRACE>, arg1: 0x2::coin::Coin<PIPMASTERRACE>) {
        0x2::coin::burn<PIPMASTERRACE>(arg0, arg1);
    }

    fun init(arg0: PIPMASTERRACE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIPMASTERRACE>(arg0, 6, b"PipMasterRace", b"PipMasterRace", b"PipMasterRace", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/2017797394218258433/M0e8wLnB_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PIPMASTERRACE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIPMASTERRACE>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PIPMASTERRACE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<PIPMASTERRACE>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

