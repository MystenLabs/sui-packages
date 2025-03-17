module 0x3bc21189dede0cc5c600d05fb445b221bae570ee0690ac9a4b795c72dd777e1e::aix {
    struct AIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIX>(arg0, 6, b"AIX", b"AIX by SuiAI", b"0xaf6059f9ea73ec0ec20b197e726903402519b8b0ceb50f477565c7a20594c4ca", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1737815730713_Photoroom_54cd3de428.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

