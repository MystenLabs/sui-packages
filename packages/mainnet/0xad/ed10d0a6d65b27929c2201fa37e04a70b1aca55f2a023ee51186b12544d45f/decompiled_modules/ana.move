module 0xaded10d0a6d65b27929c2201fa37e04a70b1aca55f2a023ee51186b12544d45f::ana {
    struct ANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANA>(arg0, 9, b"ANA", b"Ana De Armas", x"4265636175736520696620736865e280997320666c61776c6573732c207768792073686f756c646ee280997420796f757220706f7274666f6c696f206265203f20f09f928e0a466f7267657420746865206d6f6f6e2c207765e2809972652073656e64696e67207468697320636f696e20737472616967687420696e746f20686572206e65787420626c6f636b6275737465722e20f09f9a80204c6574e28099732074616b652024414e412061626f76652074686520736b69657320776865726520626561757479206d656574732063727970746f206761696e73202121212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e7a5aaaa9c7a56c9903227940d1b762bblob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

