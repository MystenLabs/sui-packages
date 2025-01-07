module 0x66e75eb8d2ddd2d35ec7f66be4f97dd37a8e1264db55a3506c756532f380f869::awake {
    struct AWAKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWAKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWAKE>(arg0, 6, b"AWAKE", b"Sui Awake", x"4177616b652069732061207365616c2077686f2077616e747320746f206d6f76650a66726f6d20746865206f6365616e20746f206c616e6420696e206f7264657220746f0a6265636f6d652061206d656d65636f696e20746861742077696c6c2072756c65207468650a776f726c64", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052163_8a13ca7f06.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWAKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWAKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

