module 0xbaac4d85ae24220124bd0a3dbefe03fe68dd04e63491cfdb7790e8d7291d4c9d::soy {
    struct SOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SOY>(arg0, 6, b"Soy", b"Soy Coin Sui ", x"44697463682074686f7365207269646963756c6f757320535549206665657320616e642077656c636f6d6520746f2024534f59206e657720686f6d6520e280932053554921205468697320697320746865207374617274206f662061206d656d65206572612074686174e280997320666173742061732068656c6c2c20646972742063686561702c20616e64206865726520746f20662a636b696e672073746179210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731752602194.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SOY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SOY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

