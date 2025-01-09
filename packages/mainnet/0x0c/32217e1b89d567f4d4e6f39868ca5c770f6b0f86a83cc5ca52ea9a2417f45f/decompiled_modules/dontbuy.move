module 0xc32217e1b89d567f4d4e6f39868ca5c770f6b0f86a83cc5ca52ea9a2417f45f::dontbuy {
    struct DONTBUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONTBUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONTBUY>(arg0, 6, b"Dontbuy", b"Don't buy again this buy the real", b"Real ca 0xd0478ee3720011d954b6e8f08d1600a9dfffd546fece862dc5abf4700b6e1dc3::russianwif::RUSSIANWIF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000009998_86eeba3aaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONTBUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONTBUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

