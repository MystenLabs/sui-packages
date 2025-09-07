module 0xe8bacd2ea23a4ac7734d4abbdf800c85c31d742ad7b5d05ae0bc011917fbfb26::byka {
    struct BYKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYKA>(arg0, 9, b"BYKA", b"Baby Ika", x"4576657279206d61726b6574206379636c652063726561746573206c6567656e64732e20536f6d6520717569742c20736f6d6520636f7065e280a62042757420746865206f6e65732077686f2077696e3f205468657920434f5045204841524445522e207c20576562736974653a2068747470733a2f2f782e636f6d2f53756962616279496b61", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/tVn9igH.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

