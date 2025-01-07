module 0x8d8c5bd51aadbc4e2f12ed3425483a55d787d94c79be0e66d9123a52bd10466b::fluff {
    struct FLUFF has drop {
        dummy_field: bool,
    }

    fun init(arg0: FLUFF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FLUFF>(arg0, 6, b"Fluff", b"FluffyPaws", b" FluffyPaws | The cutest memecoin on SUI blockchain!  | Join the fluff, spread the love!  | Get ready for the launch! ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Design_sans_titre_70_fea58f9d61.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FLUFF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FLUFF>>(v1);
    }

    // decompiled from Move bytecode v6
}

