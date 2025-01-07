module 0x416cfeeb180f4518b0f2d00a6921b1ec8eba2f98a691cac05f5d9014e67b768a::clippy {
    struct CLIPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLIPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLIPPY>(arg0, 6, b"CLIPPY", b"Microsoft Mascot", x"546865206f666669636520617373697374616e74206973206120646973636f6e74696e75656420696e74656c6c6967656e74207573657220696e7465726661636520666f72204d6963726f736f6674204f6666696365207468617420617373697374656420757365727320627920776179206f6620616e20696e74657261637469766520616e696d617465642063686172616374657220776869636820696e7465726661636564207769746820746865204f66666963652068656c7020636f6e74656e742e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055782_245d53a257.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLIPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLIPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

