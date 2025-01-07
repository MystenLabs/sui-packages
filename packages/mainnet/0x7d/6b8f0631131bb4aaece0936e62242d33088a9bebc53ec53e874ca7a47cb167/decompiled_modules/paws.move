module 0x7d6b8f0631131bb4aaece0936e62242d33088a9bebc53ec53e874ca7a47cb167::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"$PAW", x"5468652023504157532043756c7420676f696ee2809920676c6f62616c2120f09f91a30a0a32304d2b20696e20746865206170702c2031304d2077616c6c65747320636f6e6e65637465642c206e6561726c7920394d20737562736372696265727320616e642061206d696c6c696f6e207374726f6e67206f6e2058210a0a504157532069732074686520666173746573742d67726f77696e6720617070206f6e2054656c656772616d20657665722e20416e64206974e2809973206f6e6c79206265656e2061207765656be280a60a0a477261622061207365617420616e64207761746368207468652073686f7720f09f90be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731095643823.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

