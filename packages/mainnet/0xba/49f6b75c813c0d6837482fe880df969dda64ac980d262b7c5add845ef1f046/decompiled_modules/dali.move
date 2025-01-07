module 0xba49f6b75c813c0d6837482fe880df969dda64ac980d262b7c5add845ef1f046::dali {
    struct DALI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DALI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DALI>(arg0, 6, b"DALI", b"KATBIDALI", b"$DALI is a fan created memecoin on SUI that celebrates the adorable KATBIDALI.Under the new community-driven management, the project donates a portion of its profits to global wildlife causes, starting with OGROD ZOOLOGICZNY W ZAMOSCU home to DALI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731506569822.avif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DALI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DALI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

