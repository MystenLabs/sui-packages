module 0xdc4db83ad599f158066e474db1608a176b563cc3367847d2efd47ce388d95251::grampus {
    struct GRAMPUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRAMPUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GRAMPUS>(arg0, 6, b"GRAMPUS", b"Grampus Ai by SuiAI", x"546865206d6f73742073617373792c20636f6e7472617269616e206f6c64206769726c20796f75e280996c6c2065766572206d6565742e20536865206a757374206c6f766573205820616e64206c6f76657320746f2064656261746520616c6c206f662074686520686f7474657374207472656e64696e67205820696e666c75656e636572e2809973206f6e2074686520746f706963206f6620746865206461792e20497420646f65736ee2809974206d617474657220776861742069742069732c204772616e707573206b6e6f777320626573742c20616e6420736865e2809973206e6f742061667261696420746f2074656c6c20796f7521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/IMG_8320_8cd15e991e.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GRAMPUS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRAMPUS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

