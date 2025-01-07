module 0x1079631e4021c30b306a4cb9398edc424168f66d12e378817865ae508e274e1f::art {
    struct ART has drop {
        dummy_field: bool,
    }

    fun init(arg0: ART, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ART>(arg0, 6, b"ART", b"Art On Sui", x"24415254206f6e20537569207c20436c617373696320417274204d656d6573207c0a436f6d696e6720736f6f6e2120204120756e6971756520626c656e64206f6620636c61737369632061727420616e64206d656d652063756c74757265206f6e207468652053756920626c6f636b636861696e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001954_85d815ec5e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ART>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ART>>(v1);
    }

    // decompiled from Move bytecode v6
}

