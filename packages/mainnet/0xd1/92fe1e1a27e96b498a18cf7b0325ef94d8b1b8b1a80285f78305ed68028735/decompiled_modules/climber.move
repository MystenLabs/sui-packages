module 0xd192fe1e1a27e96b498a18cf7b0325ef94d8b1b8b1a80285f78305ed68028735::climber {
    struct CLIMBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIMBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLIMBER>(arg0, 6, b"CLIMBER", b"Climber", x"436c696d6265722077616e747320746f2072656163682074686520746f7020616e64206265636f6d6520746865206869676865737420636c696d626572206f6620616c6c2120466f7220657665727920646f6c6c617220696e7665737465642c20686520636c696d6273206f6e65206d65746572206869676865722e2048656c702068696d20636f6e71756572206e65772068656967687473210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/12_f47bde83be.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIMBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIMBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

