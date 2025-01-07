module 0x8bb099bde1ce6ee01355df024d26a05a2e1c0e5562a4d6066b012a72cf8f9cd3::suiet {
    struct SUIET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIET>(arg0, 6, b"SUIET", b"Suieet", x"596f7520616c7761797320686176652061206368616e636520746f206d616b6520796f7572206c696665205375696565742e0a0a796f75206b6e6f77206120426c6f636b636861696e20697320676f6f64207768656e206974277320537569656521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2302_122d7de38d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIET>>(v1);
    }

    // decompiled from Move bytecode v6
}

