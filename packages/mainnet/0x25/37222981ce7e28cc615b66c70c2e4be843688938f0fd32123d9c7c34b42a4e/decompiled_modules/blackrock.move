module 0x2537222981ce7e28cc615b66c70c2e4be843688938f0fd32123d9c7c34b42a4e::blackrock {
    struct BLACKROCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLACKROCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLACKROCK>(arg0, 6, b"BLACKROCK", b"Lurry Pink", x"496e76657374206c696b65206120746974616e2c206d656d65206c696b652061206368616d704c757272792046696e6b277320676f7420796f7572206261636b210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lurry_pink_6fa8080e2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLACKROCK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLACKROCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

