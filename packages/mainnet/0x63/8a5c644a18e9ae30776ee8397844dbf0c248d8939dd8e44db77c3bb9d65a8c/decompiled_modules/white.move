module 0x638a5c644a18e9ae30776ee8397844dbf0c248d8939dd8e44db77c3bb9d65a8c::white {
    struct WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITE>(arg0, 6, b"WHITE", b"The White Meme", b"Paint white the $Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/n9x_F_Ikn_400x400_750b4b3bf8.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

