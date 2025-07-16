module 0x653e570847060b40a53ca54bd32a6007cff702f5244127442511e34ca20bc4a0::bkid {
    struct BKID has drop {
        dummy_field: bool,
    }

    fun init(arg0: BKID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<BKID>(arg0, 6, b"BKID", b"BoatKid", b"Just coll kid", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Boat_kid_edd2600ba6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BKID>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BKID>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

