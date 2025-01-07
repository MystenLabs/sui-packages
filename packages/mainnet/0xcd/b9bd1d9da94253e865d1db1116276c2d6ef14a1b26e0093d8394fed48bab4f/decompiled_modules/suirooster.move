module 0xcdb9bd1d9da94253e865d1db1116276c2d6ef14a1b26e0093d8394fed48bab4f::suirooster {
    struct SUIROOSTER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIROOSTER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIROOSTER>(arg0, 6, b"SUIROOSTER", b"Sui Rooster", b"Cock-a-doodle-doo! Im SuiRooster, the fearless leader of the barnyard.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Asset_141_2x_2048x2048_0106987a7d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIROOSTER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIROOSTER>>(v1);
    }

    // decompiled from Move bytecode v6
}

