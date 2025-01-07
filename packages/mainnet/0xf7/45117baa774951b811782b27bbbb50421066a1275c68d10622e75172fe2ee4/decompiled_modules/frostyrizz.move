module 0xf745117baa774951b811782b27bbbb50421066a1275c68d10622e75172fe2ee4::frostyrizz {
    struct FROSTYRIZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: FROSTYRIZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FROSTYRIZZ>(arg0, 6, b"FROSTYRIZZ", b"Frosty Rizz", b"Frosty RIZZ the SUI Snowman: A HailuoSUI original cooler than ice, sharper than the grind.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/452345_a64563a6cb.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FROSTYRIZZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FROSTYRIZZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

