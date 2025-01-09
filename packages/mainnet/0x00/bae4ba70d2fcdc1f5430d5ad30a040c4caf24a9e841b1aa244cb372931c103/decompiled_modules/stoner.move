module 0xbae4ba70d2fcdc1f5430d5ad30a040c4caf24a9e841b1aa244cb372931c103::stoner {
    struct STONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONER>(arg0, 6, b"STONER", b"Stoner Pepe", b" Chill vibes? Always. Good snacks? Mandatory.  Spreading peace and love, one toke at a time ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Ys_OKEG_5_F_400x400_ef549d6162.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONER>>(v1);
    }

    // decompiled from Move bytecode v6
}

