module 0xabbce377dd116e363b4dd551c52400055252b6200602b208ddd5db3512e2abe5::pdog {
    struct PDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: PDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PDOG>(arg0, 6, b"PDOG", b"Pope Dog", x"506f7065446f672069732074686520646976696e65206c6561646572206f6620616c6c20646f67732c206865726520746f20736865706865726420746865206c6f737420616e64206775696465207468656d20746f20726564656d7074696f6e2e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/L0_Aqr_PS_400x400_1185b642d2.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

