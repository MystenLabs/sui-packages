module 0x5eaa829f45d9775f5529654926c06a74bfeff8617ad5625c21e02cf6ac3796f8::jona {
    struct JONA has drop {
        dummy_field: bool,
    }

    fun init(arg0: JONA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JONA>(arg0, 6, b"JONA", b"JONA - Moo Deng's Mom", x"4a6f6e61206761766520626972746820746f206c6567656e64617279204d6f6f2044656e67206f6e204a756c7920313074682c20323032342e20546869732070726f6a65637420697320746f2073686f7720737570706f727420666f72204a6f6e6120616e6420696e6372656469626c65206d6f74686572732061726f756e642074686520776f726c642e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/OM_9_Vn934_400x400_288a56088e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JONA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JONA>>(v1);
    }

    // decompiled from Move bytecode v6
}

