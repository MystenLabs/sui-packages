module 0xe387e11744c86c0996abc6d9c7001c4493d07cc916815d8d376da5bc7ca145e6::c_f_t {
    struct C_F_T has drop {
        dummy_field: bool,
    }

    fun init(arg0: C_F_T, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C_F_T>(arg0, 6, b"C F T", b"Claynosaurz fan token", x"436c61796e6f736175727a2066616e20746f6b656e2066616972206c61756e6368200a416c6c2064657461696c7320617661696c61626c65206f6e20780a476f6f64206e657773204769766561776179206f66206f6666696369616c20636c61796e6f736175727a204e465420746f20746f70203520686f6c646572200a416c736f20696e2074616c6b732077697468205375692070726f6d6f2078206163636f756e7420746f2070726f6d206f75722070726f6a65637420737461792074756e6564", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeihfckpuv7v2lguootyt4k5tttouvacu3eg2g6pc5uioalnwtps3ku")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C_F_T>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<C_F_T>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

