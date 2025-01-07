module 0x6cedea901f101d30081575ea2f215c68d79c1f431ae4b6715d99f3695a6fdb99::dixi {
    struct DIXI has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIXI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIXI>(arg0, 6, b"DIXI", b"DIXI on SUI", b"First Pixelated Dog on SUI...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gy_Pd8q_Wu_400x400_82ddcc5418.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIXI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIXI>>(v1);
    }

    // decompiled from Move bytecode v6
}

