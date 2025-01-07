module 0xc3be51dcf2f11a45e6b56cd06769cac75352e818ee94ac7b1b7d974ac092936b::delts2 {
    struct DELTS2 has drop {
        dummy_field: bool,
    }

    fun init(arg0: DELTS2, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DELTS2>(arg0, 9, b"DELTS2", b"DeathEleme", x"d09cd18b202d20d0bad0bed0b0d0bbd0b8d186d0b8d18f20d0bad0bbd0b0d0bdd0bed0b220446561746820456c656d656e74732e2020202020202020202020202020202020202020202020202020d098d0b3d180d0b0d0b5d0bc20d0b220576f726c64206f662054616e6b732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bbbde4e6-d2b8-49d3-83a9-c910ad13aa44.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DELTS2>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DELTS2>>(v1);
    }

    // decompiled from Move bytecode v6
}

