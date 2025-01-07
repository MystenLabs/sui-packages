module 0x50a21cf963f33d846915103c3392d88cacf5432905226f9f927b5bd587479192::suibai {
    struct SUIBAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBAI>(arg0, 6, b"SUIBAI", b"Suibai", b"HABIBI COME TO SUIBAI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_01_66_e332b75421.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

