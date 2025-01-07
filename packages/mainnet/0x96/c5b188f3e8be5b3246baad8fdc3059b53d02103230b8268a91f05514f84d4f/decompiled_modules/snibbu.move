module 0x96c5b188f3e8be5b3246baad8fdc3059b53d02103230b8268a91f05514f84d4f::snibbu {
    struct SNIBBU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNIBBU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNIBBU>(arg0, 6, b"SNIBBU", b"Snibbu the Sui", x"486572652c20796f752077696c6c2066696e6420746865206c6567656e64617279206d656d6573207468617420706572736f6e696679207468652068696768732c206c6f77732c20616e64207369646577617973206d6f766573206f66207468652063727970746f206d61726b6574732e0a4469766520696e746f20746865206d61646e657373206f6620426f626f2074686520426561722c20446f646f2074686520426c61636b205377616e20616e6420536e696262752074686520437261622e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Snibbu_002bf08c2f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNIBBU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNIBBU>>(v1);
    }

    // decompiled from Move bytecode v6
}

