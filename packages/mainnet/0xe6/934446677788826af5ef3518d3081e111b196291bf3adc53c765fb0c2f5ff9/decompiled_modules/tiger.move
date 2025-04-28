module 0xe6934446677788826af5ef3518d3081e111b196291bf3adc53c765fb0c2f5ff9::tiger {
    struct TIGER has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIGER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TIGER>(arg0, 6, b"TIGER", b"PumpTIGER", x"57656c636f6d6520746f2050756d7020546967657221200a50756d702054696765722069732074686520756c74696d617465206d656d6520746f6b656e206f6e2053554920436861696e2c206c61756e6368696e67206578636c75736976656c79207468726f756768204d4f564550554d502120436f6d62696e696e672074686520706f776572206f6620636f6d6d756e6974792c206d656d652063756c747572652c20616e642063727970746f20696e6e6f766174696f6e2c2050756d702054696765722069732064657369676e656420746f20726f6172207468726f75676820746865206d61726b65742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2025_03_06_at_22_11_56_7300b88776.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIGER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TIGER>>(v1);
    }

    // decompiled from Move bytecode v6
}

