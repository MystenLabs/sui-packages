module 0xa7a48941b021ca77cabaf7da8a98dc0592ee58af25f00580e846fd8f61948fbf::akai47 {
    struct AKAI47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AKAI47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AKAI47>(arg0, 6, b"AKAI47", b"AKAI", b"AKAI is an AI Agent that helps you explore deep into the global AI technology scene!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/85e5c148-2c8b-4db0-8cb8-54f3b92f6c6d.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AKAI47>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AKAI47>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

