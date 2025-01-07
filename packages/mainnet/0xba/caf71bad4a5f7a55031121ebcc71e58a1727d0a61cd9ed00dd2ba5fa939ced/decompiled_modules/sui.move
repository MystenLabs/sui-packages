module 0xbacaf71bad4a5f7a55031121ebcc71e58a1727d0a61cd9ed00dd2ba5fa939ced::sui {
    struct SUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI>(arg0, 6, b"SUI", b"Seriously Upset Indian", b"buy my coin or i will look for you and i will find you and i will kill you", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a2ae2bf9_9ac7_441d_8559_6e3eaa92b0ac_8fe9640a08.jfif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

