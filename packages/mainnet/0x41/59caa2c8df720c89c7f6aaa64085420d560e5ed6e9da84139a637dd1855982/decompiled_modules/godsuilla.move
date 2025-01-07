module 0x4159caa2c8df720c89c7f6aaa64085420d560e5ed6e9da84139a637dd1855982::godsuilla {
    struct GODSUILLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GODSUILLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GODSUILLA>(arg0, 6, b"GODSUILLA", b"GODSUILLA COIN", b"$GodSUIllais a prehistoric reptilian or dinosaurian monster that is amphibious or resides partially in the SUI, awakened and empowered after many years.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_09_040945_c0a8724cdf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GODSUILLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GODSUILLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

