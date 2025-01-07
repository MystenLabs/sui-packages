module 0xa98b142c1f4dfe1542f59c0ae3b6a8ce119c56f814f1c1ea7785c474a636ee6c::blunt {
    struct BLUNT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUNT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUNT>(arg0, 6, b"BLUNT", b"BLUNNY", b"BLUNNY THE CHAD!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/BLUNNY_b8debf322e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUNT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUNT>>(v1);
    }

    // decompiled from Move bytecode v6
}

