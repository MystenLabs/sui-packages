module 0x759ce7921a77815192fa3dd3f1e57aff8f1557b98ed854fe727fef97ec635df6::bbsui {
    struct BBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBSUI>(arg0, 6, b"BBSUI", b"Big Blue Sui Ballz", b"For all the blue ballers in criptoe ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BBC_a843831b72.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

