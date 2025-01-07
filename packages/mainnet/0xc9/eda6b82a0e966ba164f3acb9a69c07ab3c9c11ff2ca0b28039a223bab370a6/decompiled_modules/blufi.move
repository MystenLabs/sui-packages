module 0xc9eda6b82a0e966ba164f3acb9a69c07ab3c9c11ff2ca0b28039a223bab370a6::blufi {
    struct BLUFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUFI>(arg0, 6, b"BLUFI", b"Coolest blue on SUI", x"54686520636f6f6c65737420626c7565206f6e2074686520626c6f636b200a0a5374617920626c75652c20737461792024424c55464920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Pfp_1_3b88ba1f5d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

