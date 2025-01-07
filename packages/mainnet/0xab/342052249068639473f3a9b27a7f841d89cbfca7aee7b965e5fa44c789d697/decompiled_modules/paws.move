module 0xab342052249068639473f3a9b27a7f841d89cbfca7aee7b965e5fa44c789d697::paws {
    struct PAWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAWS>(arg0, 6, b"PAWS", b"PAW Community", x"4e65772050415753205461736b204a7573742044726f707065642120f09f90be0a0a4c696d697465642d74696d65206f6e6c792c20736f20796f7520626574746572206e6f7420736c656570206f6e20697420e2809420796f7520676f74206a75737420323420686f75727320746f2067657420696e2c2068616e646c6520796f757220627573696e6573732c20616e6420636c61696d2077686174e280997320796f7572732120f09f90be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731096234430.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PAWS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAWS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

