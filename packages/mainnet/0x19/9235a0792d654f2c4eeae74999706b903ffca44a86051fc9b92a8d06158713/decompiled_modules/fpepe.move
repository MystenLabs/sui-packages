module 0x199235a0792d654f2c4eeae74999706b903ffca44a86051fc9b92a8d06158713::fpepe {
    struct FPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FPEPE>(arg0, 6, b"FPEPE", b"Father Pepe", b"$FPEPE The Integrity Coin .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p4_Amed_AG_400x400_340e143552.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

