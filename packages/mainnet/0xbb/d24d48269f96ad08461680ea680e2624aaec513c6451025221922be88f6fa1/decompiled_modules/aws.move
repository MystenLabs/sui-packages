module 0xbbd24d48269f96ad08461680ea680e2624aaec513c6451025221922be88f6fa1::aws {
    struct AWS has drop {
        dummy_field: bool,
    }

    fun init(arg0: AWS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AWS>(arg0, 6, b"AWS", b"Anchor Wif Sui", x"54686520546974616e69632077656e7420646f776e2062656361757365206f66206d652c20796f7572206d6f6e65792077696c6c20676f207468652073616d6520776179200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/avas_eb7f79ec37.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AWS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AWS>>(v1);
    }

    // decompiled from Move bytecode v6
}

