module 0x58b6aa433b552b2e3ff4d374bb5b3d4c809e09bb28ca3182895d13364e91c979::joseph {
    struct JOSEPH has drop {
        dummy_field: bool,
    }

    fun init(arg0: JOSEPH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JOSEPH>(arg0, 6, b"Joseph", b"Fan Dog Of Trump", b"Number Fan Dog Of Trump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_05_00_50_52_3d0cfc6d01.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JOSEPH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JOSEPH>>(v1);
    }

    // decompiled from Move bytecode v6
}

