module 0xd9c6aeb3ce72860c3d49a40c751ae7503bd81f064b20802e65a5cf8736f13534::onyxfamiliar {
    struct ONYXFAMILIAR has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin::TreasuryCap<ONYXFAMILIAR>, arg1: 0x2::coin::Coin<ONYXFAMILIAR>) {
        0x2::coin::burn<ONYXFAMILIAR>(arg0, arg1);
    }

    fun init(arg0: ONYXFAMILIAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ONYXFAMILIAR>(arg0, 6, b"OnyxFamiliar", b"OnyxFamiliar", b"OnyxFamiliar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1966382407470436352/7qhKoYI0_normal.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ONYXFAMILIAR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ONYXFAMILIAR>>(v0, 0x2::tx_context::sender(arg1));
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ONYXFAMILIAR>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ONYXFAMILIAR>(arg0, arg1, arg2, arg3);
    }

    // decompiled from Move bytecode v6
}

