module 0x762b571cfa33d15f4cf0917fbfbc7366d88850989a4e402c3411c4a8b7026357::suiluce {
    struct SUILUCE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUILUCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUILUCE>(arg0, 6, b"SUILUCE", b"SUI LUCE", b"Meet Luce: The Vaticans cartoon mascot for Jubilee 2025", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUI_LUCE_077676b386.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUILUCE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUILUCE>>(v1);
    }

    // decompiled from Move bytecode v6
}

