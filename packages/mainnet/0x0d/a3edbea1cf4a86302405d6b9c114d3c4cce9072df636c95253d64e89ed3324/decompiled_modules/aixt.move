module 0xda3edbea1cf4a86302405d6b9c114d3c4cce9072df636c95253d64e89ed3324::aixt {
    struct AIXT has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIXT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AIXT>(arg0, 6, b"AIXT", b"AIX Terminal", x"416c2d506f77657265642043727970746f20496e7369676874733a205265616c2d54696d65205472656e64732026204d61726b65742053656e74696d656e7420416e616c797369732e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738403074420.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AIXT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIXT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

