module 0xe37683719397afb96ce591ab1a005b5aee5b984f023ff9c6509167649392357d::santawif {
    struct SANTAWIF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANTAWIF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANTAWIF>(arg0, 6, b"SANTAWIF", b"SantaWifHat", b"Santa Wif Hat on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jin_M_Ot_SN_400x400_f04e5504ae.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANTAWIF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANTAWIF>>(v1);
    }

    // decompiled from Move bytecode v6
}

