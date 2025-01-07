module 0xd9db896bb321f093294876201ef487ce9a4975f7b3259cfc75b5b24e0c0f8cf7::booshi {
    struct BOOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOSHI>(arg0, 6, b"BOOSHI", b"Booshi Space Sui", b"Staking up to 1000 APY.Join here: https://www.booshionsui.space", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_35_9875565847.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

