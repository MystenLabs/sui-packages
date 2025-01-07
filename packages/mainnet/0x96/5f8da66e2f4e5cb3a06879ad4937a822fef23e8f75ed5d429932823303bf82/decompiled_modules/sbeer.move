module 0x965f8da66e2f4e5cb3a06879ad4937a822fef23e8f75ed5d429932823303bf82::sbeer {
    struct SBEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEER>(arg0, 6, b"SBEER", b"Sui Beer", b"First Brewery on #SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/VW_Uj_Umkr_400x400_13d90cf582.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

