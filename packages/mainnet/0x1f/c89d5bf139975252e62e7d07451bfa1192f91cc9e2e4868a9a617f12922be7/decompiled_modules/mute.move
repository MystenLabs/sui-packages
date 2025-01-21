module 0x1fc89d5bf139975252e62e7d07451bfa1192f91cc9e2e4868a9a617f12922be7::mute {
    struct MUTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MUTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MUTE>(arg0, 6, b"MUTE", b"MUTE", b"https://t.me/mute_03", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/h0omlTj.jpg"))), arg1);
        let v2 = v0;
        let v3 = @0x6758d64e4d64de9615f6442dc41ea30d8374f3bc223d43e644d1679b6c094ca8;
        0x2::coin::mint_and_transfer<MUTE>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MUTE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MUTE>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

