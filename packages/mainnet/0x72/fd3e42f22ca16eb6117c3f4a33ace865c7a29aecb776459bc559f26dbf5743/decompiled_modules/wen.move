module 0x72fd3e42f22ca16eb6117c3f4a33ace865c7a29aecb776459bc559f26dbf5743::wen {
    struct WEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEN>(arg0, 6, b"WEN", b"wen hop fun", b"wen hop fun, i need more gambling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/G9_NH_V7z_400x400_f8c22db15b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

