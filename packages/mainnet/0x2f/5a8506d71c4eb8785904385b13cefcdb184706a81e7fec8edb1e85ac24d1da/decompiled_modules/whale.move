module 0x2f5a8506d71c4eb8785904385b13cefcdb184706a81e7fec8edb1e85ac24d1da::whale {
    struct WHALE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHALE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHALE>(arg0, 6, b"WHALE", b"Whale sui", x"574859205748414c453f200a4c6f7473206f66206672657368206669736820726563656e746c792e2e2e49206d65616e2e2e2e2077656c636f6d652c206e6577636f6d6572732c20746f2074686520776f6e64657266756c20776f726c64206f66205768616c652e20466f7220616c6c206f6620796f752077686f20617265206e657720616e6420776f6e646572696e672c20576861742065786163746c7920646f204920646f20686572653f20646f6e7420776f7272792e20496d206865726520746f20677569646520796f75207468726f7567682074686520776f726c64206f66205768616c696e672e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000037037_51acb6c1ff.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHALE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHALE>>(v1);
    }

    // decompiled from Move bytecode v6
}

