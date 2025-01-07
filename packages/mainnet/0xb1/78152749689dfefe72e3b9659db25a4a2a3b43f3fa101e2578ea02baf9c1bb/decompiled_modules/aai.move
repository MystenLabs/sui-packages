module 0xb178152749689dfefe72e3b9659db25a4a2a3b43f3fa101e2578ea02baf9c1bb::aai {
    struct AAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAI>(arg0, 9, b"AAI", b"A Arena", b"The first ever cryptocurrency thats made for community.  1000% for community.  We always share the legit airdrops. You can work hard to get paid.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/461dca4a-9f25-4d50-9fb8-cde69c4db577-1000015974.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

