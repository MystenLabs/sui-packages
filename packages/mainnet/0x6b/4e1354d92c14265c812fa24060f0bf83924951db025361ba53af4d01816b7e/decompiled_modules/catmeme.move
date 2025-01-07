module 0x6b4e1354d92c14265c812fa24060f0bf83924951db025361ba53af4d01816b7e::catmeme {
    struct CATMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATMEME>(arg0, 6, b"CATMEME", b"CAT", b"Cat is perfect <3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.ytimg.com/vi/eXwZMAz9Vh8/maxresdefault.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATMEME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CATMEME>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

