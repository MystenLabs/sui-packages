module 0xc3ac2437d4bc68cb750f4511782df541f2744242500a151c7581f9cb742bc679::scope {
    struct SCOPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCOPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCOPE>(arg0, 6, b"SCOPE", b"Scopecoin", x"53636f7065636f696e206973206120746f6b656e2064657369676e656420666f722074686520636f6d6d756e6974792c20616e64207269676874206e6f7720776520617265206578636974656420746f206275696c6420746f6765746865722c2074686520636f6d6d756e697479206973206672656520616e6420746865726520617265206e6f2072756c6573202453434f504520416c6c20746f20636f6d6d756e6974792047726f7774680a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036970_78a743ee3d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCOPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCOPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

