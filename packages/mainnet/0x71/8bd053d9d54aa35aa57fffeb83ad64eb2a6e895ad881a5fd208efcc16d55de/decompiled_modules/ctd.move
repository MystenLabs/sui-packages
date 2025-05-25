module 0x718bd053d9d54aa35aa57fffeb83ad64eb2a6e895ad881a5fd208efcc16d55de::ctd {
    struct CTD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTD>(arg0, 6, b"CTD", b"CATYMOON", b"$CATYMOON is moonwalking so hard, even your grandmas cats jealous!CATYMOON is moonwalking so hard, even your grandmas cats jealous!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cat_c712d63297.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTD>>(v1);
    }

    // decompiled from Move bytecode v6
}

