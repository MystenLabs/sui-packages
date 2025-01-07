module 0x4a9ee33e477544057ffee5f4452673c28a6f975728cb50121f6ec946f3c94293::wcs {
    struct WCS has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCS>(arg0, 6, b"WCS", b"WRAPPED CAT on SUI", x"57524150504544204341540a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ADAE_Xa6_N_400x400_f98d6e5cc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WCS>>(v1);
    }

    // decompiled from Move bytecode v6
}

