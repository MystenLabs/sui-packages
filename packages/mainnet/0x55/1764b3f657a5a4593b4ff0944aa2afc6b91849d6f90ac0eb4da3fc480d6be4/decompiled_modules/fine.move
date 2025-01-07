module 0x551764b3f657a5a4593b4ff0944aa2afc6b91849d6f90ac0eb4da3fc480d6be4::fine {
    struct FINE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINE>(arg0, 6, b"FINE", b"This is Fine", x"546869732069732046696e6520697320616e2069636f6e6963206d656d652063726561746564206279204b4320477265656e27732032303133207369782d70616e656c20636f6d6963204f6e20466972652e200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2024_10_13_02_56_12_bf8ccf6fac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINE>>(v1);
    }

    // decompiled from Move bytecode v6
}

