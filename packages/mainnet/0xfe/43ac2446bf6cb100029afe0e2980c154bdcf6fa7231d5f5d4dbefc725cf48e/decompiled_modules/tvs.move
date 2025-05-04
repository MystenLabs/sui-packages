module 0xfe43ac2446bf6cb100029afe0e2980c154bdcf6fa7231d5f5d4dbefc725cf48e::tvs {
    struct TVS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TVS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TVS>(arg0, 6, b"TVS", b"Trumpverse", x"5472756d702065786973747320696e2065766572792074696d656c696e652e0a48652077696e7320696e20657665727920756e6976657273652e235472756d707665727365", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Y5_W5_Q_Yqo_400x400_29feb17556.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TVS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TVS>>(v1);
    }

    // decompiled from Move bytecode v6
}

