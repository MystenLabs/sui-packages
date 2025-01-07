module 0xd310f6f91b72a5124673d4af31b32d4bd81dd8de2f1ce34df96995fca677bfeb::bas {
    struct BAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAS>(arg0, 6, b"BAS", b"BASED", b"AMERICA ELON MASK", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1500x500_1_449125cfad.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

