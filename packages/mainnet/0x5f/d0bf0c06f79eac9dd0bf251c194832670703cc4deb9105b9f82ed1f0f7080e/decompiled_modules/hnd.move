module 0x5fd0bf0c06f79eac9dd0bf251c194832670703cc4deb9105b9f82ed1f0f7080e::hnd {
    struct HND has drop {
        dummy_field: bool,
    }

    fun init(arg0: HND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HND>(arg0, 9, b"HND", b"HALK NEVER DIE", b"HALK NEVER DIE token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://readrate.com/img/pictures/basic/239/239828/2398288/w816-ce7c3f95.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HND>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HND>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HND>>(v1);
    }

    // decompiled from Move bytecode v6
}

