module 0x519b21003301b0d3eda3208878aa68de729e1c453180e5c1c698a9da34b77c79::chip {
    struct CHIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHIP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHIP>(arg0, 6, b"CHIP", b"Blue chip", b"Top tier stuff.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/q_Tgg_T_Xna_400x400_21b91c706e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHIP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHIP>>(v1);
    }

    // decompiled from Move bytecode v6
}

