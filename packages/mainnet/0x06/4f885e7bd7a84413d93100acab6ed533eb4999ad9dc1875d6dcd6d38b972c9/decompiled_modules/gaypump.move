module 0x64f885e7bd7a84413d93100acab6ed533eb4999ad9dc1875d6dcd6d38b972c9::gaypump {
    struct GAYPUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAYPUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAYPUMP>(arg0, 6, b"GAYPUMP", b"GayPump", x"4120636f696e206d61646520666f722070656f706c652077686f207468696e6b2061626f7574204d6f766550756d7020612062697420646966666572656e746c792061667465722067657474696e67207275676765642031303030303030782074696d65730a4a6f696e2074686520746720616e64206c657420746865736520666b696e2072756767657273206b6e6f772077652061696e277420676976696e6720696e2074686174206561737921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/log_A_2_3dba83f06e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAYPUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GAYPUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

