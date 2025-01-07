module 0x79e994c0c0318f6fc88b8ae038cad9a4e2b3a964c172f875a8607303d09e286c::sum {
    struct SUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUM>(arg0, 6, b"Sum", b"Sui Monster", x"537569206d6f6e737465722069732061206e6577206d656d65636f696e20616e6420616c736f206d667420636f6c6c656374696f6e2c20626573742070617274206973207468617420746865206e667420617265206672656520616e642069742077696c6c2062652073656e7420746f20616c6c20686f6c64657273206f6e63652077652063726f737320626f6e64202e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1582_3585680e2e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

