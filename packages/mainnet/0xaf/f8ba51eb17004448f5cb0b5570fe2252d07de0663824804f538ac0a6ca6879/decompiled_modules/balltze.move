module 0xaff8ba51eb17004448f5cb0b5570fe2252d07de0663824804f538ac0a6ca6879::balltze {
    struct BALLTZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALLTZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALLTZE>(arg0, 6, b"Balltze", b"Balltze on Sui", b"Cheems Balltze is a trending Instagram dog close to reaching a million followers", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0546_cb4b4d1f17.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALLTZE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALLTZE>>(v1);
    }

    // decompiled from Move bytecode v6
}

