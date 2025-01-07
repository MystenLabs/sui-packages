module 0xadea4f93d48f9871117b6525ee8bf1983d676ecdc8422abe83a3659fc7f04d18::SSHIB {
    struct SSHIB has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSHIB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSHIB>(arg0, 6, b"SSHIB", b"SSHIB Never Die", b"SuiSHIB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://i.imgur.com/fQTA2Ih.png"))), arg1);
        let v2 = v0;
        let v3 = @0x8b3d7d829e8f503c3cbde76da3486350a112b3710e29c674d729fd973f95102d;
        0x2::coin::mint_and_transfer<SSHIB>(&mut v2, 100000000000000, v3, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SSHIB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSHIB>>(v2, v3);
    }

    // decompiled from Move bytecode v6
}

