module 0x72286818a859a40463accd5fea97774645f0ad7572f181f37868aae3b8312927::buidl {
    struct BUIDL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUIDL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUIDL>(arg0, 6, b"Buidl", b"buidler", x"546865726527732061206e6577207472656e64206f6e2043727970746f2054776974746572200a0a4269672063727970746f206163636f756e74732061726520706f7374696e6720224275696c64657220537a6e2220776974682079656c6c6f77206a61636b6574207069637475726573206f6e207468656972206c6f676f732e0a0a4665656c73206c696b6520697420636f756c6420626520746865206e65787420224d4f47222063756c742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000033834_8aa754eb53.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUIDL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUIDL>>(v1);
    }

    // decompiled from Move bytecode v6
}

