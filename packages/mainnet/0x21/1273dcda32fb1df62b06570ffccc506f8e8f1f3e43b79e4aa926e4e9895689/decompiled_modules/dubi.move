module 0x211273dcda32fb1df62b06570ffccc506f8e8f1f3e43b79e4aa926e4e9895689::dubi {
    struct DUBI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUBI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DUBI>(arg0, 6, b"DUBI", b"Dubi", b"Dubi is projected to moon before the bull market", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_2024_06_20_T191309_750_cdaeb74334.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUBI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DUBI>>(v1);
    }

    // decompiled from Move bytecode v6
}

