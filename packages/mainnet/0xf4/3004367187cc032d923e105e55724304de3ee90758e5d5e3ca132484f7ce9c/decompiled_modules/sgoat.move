module 0xf43004367187cc032d923e105e55724304de3ee90758e5d5e3ca132484f7ce9c::sgoat {
    struct SGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOAT>(arg0, 6, b"sGOAT", b"Sui Goat", b"$sGOAT, is a meme token launched by the largest Sui $SUI hholder, to create fun and increase interest on the Sui chain. $sGOAT is backed up with over $300M in personal funding from its founder and trading on BlueMove.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/aq_Vb_Vzz_A_400x400_982eb07b4c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

