module 0xd04c2fda8bb0c360e6f187d1705dd8970d32a3be1693875e1187f79e5902ecd3::capybara {
    struct CAPYBARA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYBARA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYBARA>(arg0, 9, b"CAPYBARA", b"Capybara", b"Capybara on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmfYRt1M2cCr3WroyriSTiUnr6xzJgdidmgHUd2XHoWBeY"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAPYBARA>>(v1);
        0x2::coin::mint_and_transfer<CAPYBARA>(&mut v2, 1000000000000000000, @0xd1197700f14385d01cf442382eba7b2770e7b751f26bbfc7a0e76cfbce3eab1f, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CAPYBARA>>(v2);
    }

    // decompiled from Move bytecode v6
}

