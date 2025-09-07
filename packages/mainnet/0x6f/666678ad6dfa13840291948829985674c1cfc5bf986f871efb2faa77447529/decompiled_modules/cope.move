module 0x6f666678ad6dfa13840291948829985674c1cfc5bf986f871efb2faa77447529::cope {
    struct COPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COPE>(arg0, 9, b"cope", b"Cope Harder", x"4576657279206d61726b6574206379636c652063726561746573206c6567656e64732e20536f6d6520717569742c20736f6d6520636f7065e280a62042757420746865206f6e65732077686f2077696e3f205468657920434f5045204841524445522e207c20576562736974653a2068747470733a2f2f692e696d6775722e636f6d2f5838416a5466522e6a706567", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/X8AjTfR.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

