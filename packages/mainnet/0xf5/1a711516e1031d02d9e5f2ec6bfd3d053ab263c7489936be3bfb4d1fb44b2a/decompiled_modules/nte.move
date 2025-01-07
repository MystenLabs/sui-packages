module 0xf51a711516e1031d02d9e5f2ec6bfd3d053ab263c7489936be3bfb4d1fb44b2a::nte {
    struct NTE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NTE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NTE>(arg0, 9, b"NTE", b"nature", x"426c6f6f6d2077697468204e6174757265436f696e3a205468652065636f2d667269656e646c792063727970746f63757272656e63792074686174277320726f6f74656420696e207375737461696e6162696c6974792c2063756c7469766174696e6720677265656e2070726f6669747320616e64206e7572747572696e672061206865616c74687920656e7669726f6e6d656e7420666f7220616c6c2120f09f8cbf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4dabf175-f60f-4a09-ab42-24d01c4b0dae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NTE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NTE>>(v1);
    }

    // decompiled from Move bytecode v6
}

