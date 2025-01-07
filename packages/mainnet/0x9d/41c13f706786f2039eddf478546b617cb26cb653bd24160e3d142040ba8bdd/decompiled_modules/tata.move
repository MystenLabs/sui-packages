module 0x9d41c13f706786f2039eddf478546b617cb26cb653bd24160e3d142040ba8bdd::tata {
    struct TATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATA>(arg0, 6, b"TATA", b"HakunaMatata", b"Hakuna Matata Token on Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hakuna_matata_by_kuumo_d7kssx0_fullview_2842caf26e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

