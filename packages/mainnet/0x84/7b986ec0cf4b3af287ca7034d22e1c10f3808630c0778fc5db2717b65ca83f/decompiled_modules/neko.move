module 0x847b986ec0cf4b3af287ca7034d22e1c10f3808630c0778fc5db2717b65ca83f::neko {
    struct NEKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEKO>(arg0, 6, b"NEKO", b"SUI NEKO", b"Just a $NEKO purring on $SUI, ready to express its adorable roar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/i_Lxns_Xsq_400x400_8172029022.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NEKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

