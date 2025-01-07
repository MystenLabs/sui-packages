module 0xa43f890c2796ade022241f34178ce12f3031a30ccc0897e17c45a7a4ff655793::kolt {
    struct KOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLT>(arg0, 6, b"KOLT", b"Blue Kolt", x"4b6f6c742069732074686520636f6f6c6573742063617420636861726163746572206f6e205355492e20496e73706972656420627920746865204c6567656e646172792064726177696e6773206f66204d617474204675726965732720426f79277320436c756220436f6d69632e204e6f772074616b696e67206f7665722074686520535549204e6574776f726b2e204b6f6c74206973206120706c6179626f792c2061206d6f6f6e206368617365722c20616e6420746865206d6f7374207375636365737366756c20646567656e2067616d626c65722e0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Blue_Kolt_becec3ccd5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLT>>(v1);
    }

    // decompiled from Move bytecode v6
}

