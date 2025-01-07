module 0xda81c7225b440ddc0afa1f1b61a0ac208a4aaa0002daaab8e4e0c6a493a7ed33::ewoke {
    struct EWOKE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EWOKE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EWOKE>(arg0, 6, b"EWOKE", b"End Wokeness", b"The first Anti-Woke Movement on the Sui Blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Oedvh_Fe_S_400x400_b8e3b6bf83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EWOKE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EWOKE>>(v1);
    }

    // decompiled from Move bytecode v6
}

