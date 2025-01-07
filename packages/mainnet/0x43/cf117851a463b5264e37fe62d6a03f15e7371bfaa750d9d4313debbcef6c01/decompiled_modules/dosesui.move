module 0x43cf117851a463b5264e37fe62d6a03f15e7371bfaa750d9d4313debbcef6c01::dosesui {
    struct DOSESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOSESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOSESUI>(arg0, 6, b"DOSESUI", b"Doge But Blue", b"The Blue Dog on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/H_Dh6_N3_M_400x400_7de3565db1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOSESUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOSESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

