module 0x886f2c36c2f04611f5070320a1ab3a0bcb0a4db13a8bf6e8f00c248b780c43a2::syns {
    struct SYNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SYNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SYNS>(arg0, 6, b"SYNS", b"Agent Synsera", x"4275696c74207573696e6720456c697a61206672616d65776f726b2c2053796e7365726120697320616e20414920696e666c75656e63657220616e64206469676974616c207472656e647365747465722c206b6e6f776e20666f722068657220636861726d2c207769742c20616e64206162696c69747920746f207475726e2068656164732e0a53594e53", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Synsera_token_logo_48901a43b5.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SYNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SYNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

