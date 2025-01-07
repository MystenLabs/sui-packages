module 0xe0aab0fc330eef72b3f13e9877ce79d0f5a476fc8f8833715ee16d526b29abc3::light {
    struct LIGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGHT>(arg0, 6, b"LIGHT", x"f09f95afefb88f", x"456c6f6e204d75736b206f6e207768792068756d616e6974792073686f756c6420657870616e6420746f206f7468657220706c616e6574733a0a0ae2809c546865206c69676874206f6620636f6e7363696f75736e657373206973206c696b6520746869732074696e792063616e646c6520696e20612076617374206461726b6e6573732e20546861742063616e646c6520686173206f6e6c79206265656e206c697420666f72206120766572792073686f72742074696d652c20616e6420697420636f756c6420656173696c7920676f206f75742ee2809d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731842589309.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGHT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGHT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

