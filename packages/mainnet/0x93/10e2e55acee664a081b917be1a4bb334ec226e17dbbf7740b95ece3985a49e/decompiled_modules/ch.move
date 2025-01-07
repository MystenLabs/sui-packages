module 0x9310e2e55acee664a081b917be1a4bb334ec226e17dbbf7740b95ece3985a49e::ch {
    struct CH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CH>(arg0, 6, b"CH", b"Celestial Horse", x"54686520636f6c6f7266756c2063656c65737469616c20686f727365206973206d61676963616c2e204f776e696e67206974206d65616e73207765616c74682e2048616e64736f6d65207769746820636f6c6f7266756c2077696e677320616e642061207669676f726f7573207374616e63652c206974206272696e6773207269636865732e204974206272696e677320776973646f6d20616e6420696e737069726174696f6e2e204974277320746865206b657920746f207765616c74682e204c657427732068617665206f6e6520616e6420656d6272616365207765616c74682e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/CH_TT_Jbfy_xq_Mxv7_B8hr_FX_102940090e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CH>>(v1);
    }

    // decompiled from Move bytecode v6
}

