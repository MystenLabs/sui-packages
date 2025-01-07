module 0xc39e32a2832278d999afb0af9eb31a886c1b4fe00ffface6096613cd1252b886::uni {
    struct UNI has drop {
        dummy_field: bool,
    }

    fun init(arg0: UNI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UNI>(arg0, 6, b"UNI", b"", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://strapi-dev.scand.app/uploads/Uni_logo_fc8235c66c.jpg"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<UNI>(&mut v2, 1000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UNI>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<UNI>>(v2);
    }

    // decompiled from Move bytecode v6
}

