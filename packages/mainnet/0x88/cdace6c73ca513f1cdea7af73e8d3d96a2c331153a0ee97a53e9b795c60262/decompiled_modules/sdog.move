module 0x88cdace6c73ca513f1cdea7af73e8d3d96a2c331153a0ee97a53e9b795c60262::sdog {
    struct SDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<SDOG>(arg0, 6, b"SDOG", b"SDOG Token", b"SDOG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gabe_the_Dog_f6aa0a42f7.png")), false, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDOG>>(v2);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<SDOG>>(v1, 0x2::tx_context::sender(arg1));
        let v3 = v0;
        0x2::coin::mint_and_transfer<SDOG>(&mut v3, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDOG>>(v3, @0x0);
    }

    // decompiled from Move bytecode v6
}

