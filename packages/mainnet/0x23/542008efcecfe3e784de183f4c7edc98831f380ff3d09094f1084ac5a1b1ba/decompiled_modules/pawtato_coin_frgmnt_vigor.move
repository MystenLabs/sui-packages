module 0x23542008efcecfe3e784de183f4c7edc98831f380ff3d09094f1084ac5a1b1ba::pawtato_coin_frgmnt_vigor {
    struct PAWTATO_COIN_FRGMNT_VIGOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWTATO_COIN_FRGMNT_VIGOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWTATO_COIN_FRGMNT_VIGOR>(arg0, 9, b"FRGMT_VIGOR", b"Pawtato Fragment of Vigor", b"Raw vitality thrums inside this piece. It is said to reflect the endurance of the first Pawtato to ever conquer the wilderness.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://img.pawtato.app/land/_resources/fragment-of-vigor.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWTATO_COIN_FRGMNT_VIGOR>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWTATO_COIN_FRGMNT_VIGOR>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

