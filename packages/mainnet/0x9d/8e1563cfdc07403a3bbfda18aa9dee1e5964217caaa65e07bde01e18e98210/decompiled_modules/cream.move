module 0x9d8e1563cfdc07403a3bbfda18aa9dee1e5964217caaa65e07bde01e18e98210::cream {
    struct CREAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CREAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CREAM>(arg0, 6, b"CREAM", b"Cats Rule Everything Around Me", x"7765206c697665206279207468652063617420616e642064696520627920746865206361742e200a0a636174732072756c6520736f20776520666f6c6c6f77207468652063617420636f64652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/w_Qio1w0r_400x400_91395e4bc7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CREAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CREAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

