module 0x5138f0d77fffb84afc9b75bcb28280559f4e4de268caeb2eeb69f80c14cdb09c::moon {
    struct MOON has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOON>(arg0, 6, b"MOON", b"Lets go to moon", x"4e415341204d6f6f6e204d697373696f6e20284e415341290a4e41534120e28093204e415341204d6f6f6e204d697373696f6e20f09f9a8020537472617020696e2c206675747572652073706163652062696c6c696f6e616972657321204e41534120636f696e2069736ee2809974206a75737420616e20696e766573746d656e7420e28093206974e28099732061206c61756e636870616420746f20746865204d6f6f6e2c204d6172732c20616e64206265796f6e642e20f09f8c95f09f92b02057696c642046696e616e6369616c2041737069726174696f6e733a20e280a2204265636f6d6520612073706163652062696c6c696f6e616972652c20627579206120766163617469", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1740839911599.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

