module 0x589d41a13feb8bb3dd6f79724df78ce565d00fc7e9abfe0bf22a33b837e2e54c::sdao {
    struct SDAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDAO>(arg0, 9, b"SDAO", b"SDAO", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://strapi-dev.scand.app/uploads/Dark_Machine_logo_f872a99525.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDAO>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SDAO>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDAO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

