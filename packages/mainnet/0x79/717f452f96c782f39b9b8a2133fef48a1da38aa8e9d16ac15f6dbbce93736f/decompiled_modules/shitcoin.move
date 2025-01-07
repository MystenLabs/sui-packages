module 0x79717f452f96c782f39b9b8a2133fef48a1da38aa8e9d16ac15f6dbbce93736f::shitcoin {
    struct SHITCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHITCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHITCOIN>(arg0, 6, b"Shitcoin", b"Norme", x"2a2a636865636b2078206f722070756d702e66756e20666f72206c69766573747265616d2a2a0a4c495645204f4e20544f494c455420554e54494c2035304d202853484954434f494e290a696d2073697474696e67206f6e207468697320746f696c657420616e64206e6f74206c656176696e6720756e74696c2035306d206d61726b6574636170206e6f206d61747465722077686174212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1431_1e7f64911f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHITCOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SHITCOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

