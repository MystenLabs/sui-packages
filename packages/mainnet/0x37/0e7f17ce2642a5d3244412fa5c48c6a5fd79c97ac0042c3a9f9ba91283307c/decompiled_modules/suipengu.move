module 0x370e7f17ce2642a5d3244412fa5c48c6a5fd79c97ac0042c3a9f9ba91283307c::suipengu {
    struct SUIPENGU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIPENGU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIPENGU>(arg0, 6, b"SuiPengu", b"Sui Penguin with Hat", x"54686520666c796573742070656e6775696e206f6e2074686520626c6f636b636861696e2c20726f636b696e67206120746f70206861742c20736c6964696e67207468726f756768207468652053756920636861696e206c696b65206974e2809973206672657368206963652e204865e2809973206865726520746f20646f6d696e61746520746865206d656d652067616d6520776974682069637920636f6e666964656e636520616e6420736d6f6f74682d636861696e206d6f7665732e204865e280997320676f74207374796c652c20737761676765722c20616e642068652773206272696e67696e6720746865206368696c6c20746f20576562332e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1749518015910.jfif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIPENGU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIPENGU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

