module 0x385f4fcce4e80b4c10d94af3aa84e5be40cf177d120a6576dec31d50815f121e::zs {
    struct ZS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZS>(arg0, 6, b"ZS", b"ZEUS", x"536f6f6e2077652077696c6c206c61756e636820746865206e657765737420636f696e20746861742077696c6c207368616b652074686520776f726c64207769746820697473206c696768746e696e672c206c6f6f6b20666f727761726420746f20697420736f6f6e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034990_3d244510d1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZS>>(v1);
    }

    // decompiled from Move bytecode v6
}

