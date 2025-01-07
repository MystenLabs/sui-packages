module 0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::drwtest {
    struct DRWTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRWTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<u8>>();
        let v1 = &mut v0;
        0x1::vector::push_back<vector<u8>>(v1, 0x2::hex::decode(b"004014267701ec6c0396ffa0479c8f6ff35f30e0302763a9b2daa6f14d2abc68de"));
        0x1::vector::push_back<vector<u8>>(v1, 0x2::hex::decode(b"00fd91cf8e54d470350cd75973d6707625ae5cf661fdebbda0f2c28497b33450b1"));
        0x1::vector::push_back<vector<u8>>(v1, 0x2::hex::decode(b"0089f74f30f0563d2d399d5970e0b509e0dfefb018a6eaca6fa7549718afe9a699"));
        let v2 = 0x1::vector::empty<vector<u8>>();
        let v3 = &mut v2;
        0x1::vector::push_back<vector<u8>>(v3, 0x2::hex::decode(b"00253d2a8c969096ae100aeec9ff2dc99aa2e56a5461621de4497cc8a4a4016eae"));
        0x1::vector::push_back<vector<u8>>(v3, 0x2::hex::decode(b"001b151f4b992d6996751d37f662fad3947c7580a16ea3d37fca674d230ffe0086"));
        0x1::vector::push_back<vector<u8>>(v3, 0x2::hex::decode(b"0011aa538b065380fac84c0d2c88358a1f75ab4e3de7dcf5298010f71a5e9e7fec"));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRWTEST>>(0xfc699b39e2e9d02d99a08d25d621982887c7d586bceeab5e20ff8743a7d771b4::setup::setup<DRWTEST>(arg0, 6, b"DRWTEST", b"DRWTEST", b"DRWTEST", 0x1::option::none<0x2::url::Url>(), @0xd5b9536b2734406d628e7629d5690e6e493d2e1b3f086db150e58f1ae0940a96, v0, x"010101", 2, @0x78eaec7774e510a3c60305448c90f03446783fb15c9c74ab78ad97e1763d864c, v2, x"010101", 2, @0x540a0cf8de472279e3c584094e1e140ffe401186fb986a795c8bd13f2f617326, arg1));
    }

    // decompiled from Move bytecode v6
}

