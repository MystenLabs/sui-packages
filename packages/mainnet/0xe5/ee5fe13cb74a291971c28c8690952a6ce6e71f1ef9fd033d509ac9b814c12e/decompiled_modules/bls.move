module 0xe5ee5fe13cb74a291971c28c8690952a6ce6e71f1ef9fd033d509ac9b814c12e::bls {
    struct BLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLS>(arg0, 6, b"BLS", b"Balls", x"42616c6c732045796520697320746865206d656d65636f696e2074686174206869747320646561642063656e7465722e0a4275696c7420666f7220707265636973696f6e2c206368616f732c20616e6420646567656e20676c6f72792c2024424559452074616b65732061696d20617420746865205375692065636f73797374656d20776974682072617720656e657267792c20766972616c20706f7765722c20616e64206e6f206d657263792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifkqgl5h6ehgny2n6mpzwmoznwarkgv3frke7xxrcw6c4mwknxccu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

