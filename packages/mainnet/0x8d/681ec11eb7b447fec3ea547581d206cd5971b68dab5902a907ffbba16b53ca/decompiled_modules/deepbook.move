module 0x8d681ec11eb7b447fec3ea547581d206cd5971b68dab5902a907ffbba16b53ca::deepbook {
    struct DEEPBOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEEPBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DEEPBOOK>(arg0, 6, b"DEEPBOOK", b"DeepBook on Sui", b"Deepbook CTO, make a telegram and let's send it!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_a01a35d5c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEEPBOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEEPBOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

