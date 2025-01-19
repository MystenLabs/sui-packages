module 0xf42b5c6f4e81db074c616a9a447f67174b43b7ce93456d05e972fd4dcd75e78e::elon {
    struct ELON has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELON, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELON>(arg0, 6, b"ELON", b"Official Elon Coin", x"5374696c6c2067726f77696e672e0a5374696c6c20657870616e64696e672e0a4e6f2073746f7070696e672e0a0a24454c4f4e206d61646520697420746f2074686520546f702031206f6e20537569210a0a24454c4f4e206973206865726520746f20646f6d696e617465206f6e20736f6c616e6120616c726561647920776520617265202e205468616e6b20796f7520666f7220796f757220696e6372656469626c6520737570706f7274e2809468657265e280997320746f20746865206675747572652c20616e6420746f206d616e79206d6f72652073756363657373657320746f6765746865722120f09f9a800a0a5769746820677261746974756465", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737314025010.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELON>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELON>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

