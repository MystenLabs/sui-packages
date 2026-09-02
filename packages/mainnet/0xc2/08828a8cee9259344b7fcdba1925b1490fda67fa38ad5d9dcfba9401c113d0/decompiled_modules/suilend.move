module 0xc208828a8cee9259344b7fcdba1925b1490fda67fa38ad5d9dcfba9401c113d0::suilend {
    struct SUILEND has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILEND, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000021128-xoELZMGGV7KLLECtqXlEZkfGlZIMIc.jpg";
        let v1 = if (0x1::vector::length<u8>(&v0) < 2) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gyezvyk0nlwtunwb.public.blob.vercel-storage.com/tokens/1000021128-xoELZMGGV7KLLECtqXlEZkfGlZIMIc.jpg"))
        };
        let (v2, v3) = 0x2::coin::create_currency<SUILEND>(arg0, 9, b"SUILEND", b"Suilend", x"537569277320446546692073756974653a204c656e64696e672c2040737072696e6773756920696e66696e697465206c6971756964207374616b696e672c20616e642040737465616d6d6669207375706572666c756964204445580a0a582068747470733a2f2f782e636f6d2f7375696c656e6470726f746f636f6c0a54656c656772616d2068747470733a2f2f742e6d652f7375696c656e6470726f746f636f6c0a576562736974652068747470733a2f2f7375696c656e642e6669", v1, arg1);
        let v4 = v2;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUILEND>>(v3);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILEND>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<SUILEND>>(0x2::coin::mint<SUILEND>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

