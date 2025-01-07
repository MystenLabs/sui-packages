module 0xe13552df2fff4848e6c6d5b24686e0b38b8553cc44343a7700af3619e28fa927::normecoin {
    struct NORMECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NORMECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NORMECOIN>(arg0, 6, b"Normecoin", b"Norme", x"2a2a636865636b2078206f722070756d702e66756e20666f72206c69766573747265616d2a2a0a4c495645204f4e20544f494c455420554e54494c2035304d202853484954434f494e290a696d2073697474696e67206f6e207468697320746f696c657420616e64206e6f74206c656176696e6720756e74696c2035306d206d61726b6574636170206e6f206d61747465722077686174212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1433_cb53ba8383.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NORMECOIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NORMECOIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

