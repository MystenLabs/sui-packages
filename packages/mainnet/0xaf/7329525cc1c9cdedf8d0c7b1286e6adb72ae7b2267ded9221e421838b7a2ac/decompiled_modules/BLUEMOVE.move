module 0xaf7329525cc1c9cdedf8d0c7b1286e6adb72ae7b2267ded9221e421838b7a2ac::BLUEMOVE {
    struct BLUEMOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEMOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x2::coin::create_regulated_currency_v2<BLUEMOVE>(arg0, 9, b"TARZAN", b"Bez gasti", b"Sweety the evil on SUI 1M $$$$ token comming soon", 0x1::option::none<0x2::url::Url>(), false, arg1);
        let v3 = v0;
        0x2::coin::mint_and_transfer<BLUEMOVE>(&mut v3, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUEMOVE>>(v2);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEMOVE>>(v3, @0xfb0ce8a725e0141a8a5331829a155a5c66bbb047002de9f0afb4b694f4103d9f);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<BLUEMOVE>>(v1, @0xfb0ce8a725e0141a8a5331829a155a5c66bbb047002de9f0afb4b694f4103d9f);
    }

    // decompiled from Move bytecode v6
}

