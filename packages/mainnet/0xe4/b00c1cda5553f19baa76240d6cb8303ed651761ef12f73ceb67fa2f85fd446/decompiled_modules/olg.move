module 0xe4b00c1cda5553f19baa76240d6cb8303ed651761ef12f73ceb67fa2f85fd446::olg {
    struct OLG has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OLG>(arg0, 6, b"OLG", b"Our Lady of Guadalupe", b"$OLG Meme token for Queen Mary or Our Lady of Guadalupe.  We are on $SUI Network launching on MovePump.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Queen_Mary_3d995918af.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLG>>(v1);
    }

    // decompiled from Move bytecode v6
}

