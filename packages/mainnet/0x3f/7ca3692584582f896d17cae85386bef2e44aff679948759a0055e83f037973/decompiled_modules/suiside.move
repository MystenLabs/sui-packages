module 0x3f7ca3692584582f896d17cae85386bef2e44aff679948759a0055e83f037973::suiside {
    struct SUISIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISIDE>(arg0, 6, b"SIDE", b"SUISIDE", b"If you're tired of being wrong, join the right side, the SuiSide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1834910926216253440/v-xMAkok_400x400.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUISIDE>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISIDE>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISIDE>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

