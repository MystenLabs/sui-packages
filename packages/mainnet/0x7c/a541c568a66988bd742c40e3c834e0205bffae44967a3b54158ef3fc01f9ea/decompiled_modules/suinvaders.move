module 0x7ca541c568a66988bd742c40e3c834e0205bffae44967a3b54158ef3fc01f9ea::suinvaders {
    struct SUINVADERS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUINVADERS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUINVADERS>(arg0, 6, b"SUINVADERS", b"SuInvaders", b"Welcome to the #SUINVADERS community! Let's reach for the sky and beyond! Our journey won't end at the Moon; we'll keep going far beyond that.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/output_Photoroom_a20755c9fa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUINVADERS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUINVADERS>>(v1);
    }

    // decompiled from Move bytecode v6
}

