module 0xbc024e9120f1cef392c52057d54d04c0d4f5bd7ea67925733aba59656c6f4e54::stonkspepe {
    struct STONKSPEPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STONKSPEPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STONKSPEPE>(arg0, 6, b"STONKSPEPE", b"Pepe6900", x"5072657061726520746f206d65657420746865206265737420506570652036393030206f662074686520537569206e6574776f726b2c20436f6d652066726f6d20746865204772656174204c65617020696e2074686973204f6365616e2e0a544720742e6d652f50657065655f363930300a58782e636f6d2f50657065363930305f5375690a576562736974652068747470732f2f50657065363930307375692e78797a2028736f6f6e29", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/welcome_pepe_6c05c25101.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STONKSPEPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STONKSPEPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

