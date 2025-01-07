module 0xa7fc88bf27623026eabe540b3d1a6035269f956c86b66c5bb85b4767c80fd66f::spizza {
    struct SPIZZA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPIZZA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPIZZA>(arg0, 6, b"SPIZZA", b"SuiPizza", x"53756950697a7a6120e2809320f09f8d9520546865206d656d65636f696e2074686174e280997320617320686f7420617320612066726573682070697a7a61206f7574206f6620746865206f76656e2120f09f9a800a4c61756e63686564206f6e207468652053756920626c6f636b636861696e2c2053756950697a7a6120636f6d62696e6573207468652066756e206f66206d656d652063756c74757265207769746820746865206578636974656d656e74206f662063727970746f2e0af09f94a5204e6f74206a757374206120636f696e2c20697427732061206c6966657374796c652e2041726520796f752068756e6772793f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732387989202.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPIZZA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPIZZA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

