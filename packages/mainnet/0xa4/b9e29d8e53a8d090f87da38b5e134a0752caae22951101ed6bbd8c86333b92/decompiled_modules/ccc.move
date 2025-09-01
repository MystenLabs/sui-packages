module 0xa4b9e29d8e53a8d090f87da38b5e134a0752caae22951101ed6bbd8c86333b92::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 6, b"CCC", b"CCC", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CCC>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CCC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

