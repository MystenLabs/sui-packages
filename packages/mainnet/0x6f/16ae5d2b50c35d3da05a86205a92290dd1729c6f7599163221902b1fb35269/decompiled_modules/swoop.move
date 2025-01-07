module 0x6f16ae5d2b50c35d3da05a86205a92290dd1729c6f7599163221902b1fb35269::swoop {
    struct SWOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWOOP>(arg0, 6, b"Swoop", b"SwoopOnSui", x"5765e280997265206120706f77657266756c20636f6d6d756e6974792070726f6a6563742c20726561647920746f2074616b65206f7665722053756920696e207374796c652e204765742070726570617265642062656361757365207765e2809972652061626f757420746f2066696c6c20796f7572206261677320776974682053776f6f702c20616e6420796f7520776f6ee28099742077616e7420746f206d697373206f757421204a6f696e20757320666f722074686973206578636974696e67206a6f75726e657920746f20746865206d6f6f6e2120f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730987805794.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWOOP>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWOOP>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

