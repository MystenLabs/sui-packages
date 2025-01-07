module 0x5272ad66d79e5d2bf3b4dbbfce8efba68dea5decc58836ee6ecf8e9dbfd65b07::bplaty {
    struct BPLATY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPLATY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BPLATY>(arg0, 6, b"BPLATY", b"Baby Platypus", b"Baby Platypus Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/500x500_27_c2ca444e24.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPLATY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPLATY>>(v1);
    }

    // decompiled from Move bytecode v6
}

