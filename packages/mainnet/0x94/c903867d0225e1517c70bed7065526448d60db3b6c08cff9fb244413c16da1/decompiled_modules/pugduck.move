module 0x94c903867d0225e1517c70bed7065526448d60db3b6c08cff9fb244413c16da1::pugduck {
    struct PUGDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUGDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUGDUCK>(arg0, 6, b"PUGDUCK", b"Pug on Duck", x"4d653f204f682c2074686520276f6f70736965272077686f20736b65646164646c65642066726f6d2074686174206368696c6c7920626565702d626f6f7020706c6163652e204c6f6f6b20617420616c6c20746865736520737469746368792062697473204920676f7421204b6565702077616e646572696e272c206b656570206c6f6f6b696e272e2e2e20646f696ee28099207768617420666f723f204875683f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731044851985.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUGDUCK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUGDUCK>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

