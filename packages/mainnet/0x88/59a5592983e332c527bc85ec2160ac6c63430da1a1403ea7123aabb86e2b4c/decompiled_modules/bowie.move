module 0x8859a5592983e332c527bc85ec2160ac6c63430da1a1403ea7123aabb86e2b4c::bowie {
    struct BOWIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOWIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOWIE>(arg0, 6, b"BOWIE", b"Elon Musk - Bowie", x"48657920477579732120456c6f6e204d75736b20616e6420446f6773202120576520617265205265616479206f722061726520796f752072656164790a0a536f6369616c73203a200a0a41726368697665203a2068747470733a2f2f617263686976652e6f72672f64657461696c732f656c6f6e2d6d75736b2d62792d77616c7465722d6973616163736f6e2f706167652f6e35352f6d6f64652f3275703f713d626f776965200a0a54776974746572203a2068747470733a2f2f782e636f6d2f456c6f6e4d75736b426f7769650a0a54656c656772616d203a2068747470733a2f2f742e6d652f656c6f6e6d75736b626f7769650a0a4c6175", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731106380119.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOWIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOWIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

