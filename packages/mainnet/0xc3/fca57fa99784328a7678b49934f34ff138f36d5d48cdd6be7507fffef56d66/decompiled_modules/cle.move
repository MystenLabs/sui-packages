module 0xc3fca57fa99784328a7678b49934f34ff138f36d5d48cdd6be7507fffef56d66::cle {
    struct CLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLE>(arg0, 6, b"CLE", b"Circle", x"436972636c652069732061206e6f6e2d70726f66697420636f6d70616e792077686f73652061726561206f6620e2808be2808b6f7065726174696f6e73206973207072696d6172696c792064656469636174656420746f207468652077656c6c2d6265696e67206f662070656f706c6520616e6420616e696d616c732e2057652073746172742077686572652068656c7020697320757267656e746c79206e65656465642e20576520617265207374726f6e67657220746f6765746865722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733402531055.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CLE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

