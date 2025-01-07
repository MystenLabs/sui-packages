module 0x8b3ae103d3c996ff796b0cd875cb271f3b7181ef92c0236274201da894408d52::zaar {
    struct ZAAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZAAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZAAR>(arg0, 6, b"ZAAR", b"ORDZAAR", b"A simple & permissionless way for artists to launch on #Ordinals  ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Zaar_42befe62eb.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZAAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZAAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

