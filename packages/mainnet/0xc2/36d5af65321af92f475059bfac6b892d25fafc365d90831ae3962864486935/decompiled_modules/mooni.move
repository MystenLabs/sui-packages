module 0xc236d5af65321af92f475059bfac6b892d25fafc365d90831ae3962864486935::mooni {
    struct MOONI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONI>(arg0, 6, b"MOONI", b"MOONI THE MOONBOY", b"$MOONI represents the eternal light that guides us through uncertain times.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiae7p5kcyeza32pjbkulvywblybfbk3kjanuimeltlo5ss3tt7aam")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOONI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

