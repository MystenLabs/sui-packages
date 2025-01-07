module 0x67bb14e2a2485b99f6dd7e5017d89dd6b483ef5a252e8bff1dbb8ac0c8d53a9c::nuggie {
    struct NUGGIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUGGIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUGGIE>(arg0, 6, b"NUGGIE", b"Nuggie ini", b"The Tastiest Dog on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000050014_eebe349202.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUGGIE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUGGIE>>(v1);
    }

    // decompiled from Move bytecode v6
}

