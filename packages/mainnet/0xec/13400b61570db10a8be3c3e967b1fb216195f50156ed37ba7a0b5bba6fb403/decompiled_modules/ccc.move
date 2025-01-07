module 0xec13400b61570db10a8be3c3e967b1fb216195f50156ed37ba7a0b5bba6fb403::ccc {
    struct CCC has drop {
        dummy_field: bool,
    }

    fun init(arg0: CCC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CCC>(arg0, 6, b"CCC", b"Coconut Chicken", x"496e737069726564206279204576616e204368656e2074776565742061736b696e67207468652053756920636f6d6d756e69747920746f206372656174652061206d656d6520746f6b656e2063616c6c65642022436f636f6e757420436869636b656e2d2024434343220a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Aa_Hr_X_SG_400x400_69cfc5ea6c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CCC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CCC>>(v1);
    }

    // decompiled from Move bytecode v6
}

