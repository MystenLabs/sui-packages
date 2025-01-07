module 0xb2d8e9bf68adb4eebd01cedb550d6e613c4a4cf59266daa4c6eb9bf90756508f::suishi {
    struct SUISHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISHI>(arg0, 9, b"SUISHI", b"SUISHI", b"8", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.google.com/url?sa=i&url=https%3A%2F%2Fsushi-point.com.ua%2Fen%2Fprod-filadelfiya-original&psig=AOvVaw2P-1nzBa8BX3Jwv-rQiSTV&ust=1706457115527000&source=images&cd=vfe&opi=89978449&ved=2ahUKEwi3zOqi9v2DAxViSmwGHTiaBNMQr4kDegUIARCGAQ")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUISHI>(&mut v2, 5151515151000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISHI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

