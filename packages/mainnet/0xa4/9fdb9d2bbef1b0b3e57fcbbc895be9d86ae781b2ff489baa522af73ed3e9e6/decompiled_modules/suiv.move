module 0xa49fdb9d2bbef1b0b3e57fcbbc895be9d86ae781b2ff489baa522af73ed3e9e6::suiv {
    struct SUIV has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIV>(arg0, 6, b"SUIV", b"Suiii Victory", x"416e6420697427732073756969692c2073756969692c20737569696920766963746f72792c2059454148210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0357_4acc64989c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIV>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIV>>(v1);
    }

    // decompiled from Move bytecode v6
}

