module 0xa55f82398c3e93fce2677ba602c7963a52a493e3c3077489ce1171cf3ba95015::ctbrgr {
    struct CTBRGR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTBRGR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTBRGR>(arg0, 6, b"CTBRGR", b"CAT BURGER", x"5461737479206c696b652061206275726765722c206d7973746572696f7573206c696b652061206361742e200a49742773207468652063727970746f63757272656e63792074686174207075727273207768656e20796f7520686f6c6420697420616e64206c65617073207768656e2069742067726f7773210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Cat_Burger_e1f528243c.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTBRGR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTBRGR>>(v1);
    }

    // decompiled from Move bytecode v6
}

