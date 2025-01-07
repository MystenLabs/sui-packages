module 0x47c5ab025bca9376cf07a1f5c973b7b4f59ef86f0aeacc3674f37226e2903ed8::brett {
    struct BRETT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRETT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRETT>(arg0, 6, b"BRETT", b"Brett on Sui", x"54686520636f6d6d756e6974792064726976656e206d6173636f7420244252455454206f6e200a405375694e6574776f726b0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BRET_b03fca9f95.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRETT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRETT>>(v1);
    }

    // decompiled from Move bytecode v6
}

