module 0xf2d34e3206cab5a7470d655790a3f3cd48b85ad24585323edaccbdda0bbef601::ETR {
    struct ETR has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETR>(arg0, 9, b"ETR", b"ETR", b"ETR", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETR>>(v1);
        0x2::coin::mint_and_transfer<ETR>(&mut v2, 226600000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ETR>>(v2);
    }

    // decompiled from Move bytecode v6
}

