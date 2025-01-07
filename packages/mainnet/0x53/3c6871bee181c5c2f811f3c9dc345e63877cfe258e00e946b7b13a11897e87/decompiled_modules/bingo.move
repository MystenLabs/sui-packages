module 0x533c6871bee181c5c2f811f3c9dc345e63877cfe258e00e946b7b13a11897e87::bingo {
    struct BINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGO>(arg0, 6, b"BINGO", b"BINGO on SUI", b"Bingo is a little ball of energy! Shes kind, curious, determined and loves to laugh. More than anything, she loves diving into pretend games with her big sister, Bluey, their friends, and family.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Bingo_on_Sui_0fd959b4fc.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BINGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

