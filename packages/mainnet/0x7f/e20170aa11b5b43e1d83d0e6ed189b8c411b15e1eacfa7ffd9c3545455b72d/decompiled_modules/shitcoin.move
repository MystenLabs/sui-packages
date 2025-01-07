module 0x7fe20170aa11b5b43e1d83d0e6ed189b8c411b15e1eacfa7ffd9c3545455b72d::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITCOIN>(arg0, 6, b"Shitcoin", b"Norme", x"2a2a204c69766573747265616d206f6e2058202a2a0a4c495645204f4e20544f494c455420554e54494c2035304d202853484954434f494e290a696d2073697474696e67206f6e207468697320746f696c657420616e64206e6f74206c656176696e6720756e74696c2035306d206d61726b6574636170206e6f206d61747465722077686174212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1431_2f77547dff.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

