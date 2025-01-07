module 0xa3bcf12b59e08f88957e6601cab58b2dda0ef506e47a7b53262970358e616d9d::spopcat {
    struct SPOPCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPOPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPOPCAT>(arg0, 6, b"SPOPCAT", b"POPCAT on SUI", b"popcat on sui the new generation of memes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/326ab82a0b4de34ce1b196b149986617_afc518db89.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPOPCAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPOPCAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

