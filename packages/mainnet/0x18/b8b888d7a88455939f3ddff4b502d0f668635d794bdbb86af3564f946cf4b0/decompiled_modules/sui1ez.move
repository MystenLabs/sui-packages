module 0x18b8b888d7a88455939f3ddff4b502d0f668635d794bdbb86af3564f946cf4b0::sui1ez {
    struct SUI1EZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI1EZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI1EZ>(arg0, 6, b"Sui1Ez", b"Sui1Ez AI", x"535549206e6574776f726b277320666972737420616e696d652d62617365642041492070726f6a656374200a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LHQ_Hmwy7_400x400_23057390cc.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI1EZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI1EZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

