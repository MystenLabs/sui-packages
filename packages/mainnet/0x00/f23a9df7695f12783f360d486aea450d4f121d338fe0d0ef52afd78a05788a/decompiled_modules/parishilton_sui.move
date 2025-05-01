module 0xf23a9df7695f12783f360d486aea450d4f121d338fe0d0ef52afd78a05788a::parishilton_sui {
    struct PARISHILTON_SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PARISHILTON_SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PARISHILTON_SUI>(arg0, 9, b"parishiltonSUI", b"Paris Hilton Staked SUI", b"In tribute to a fan of NFT's Paris Hilton.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.tusky.io/files/b1a62a47-9f8a-4ca2-82cb-1d27e26b0752/data")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PARISHILTON_SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PARISHILTON_SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

