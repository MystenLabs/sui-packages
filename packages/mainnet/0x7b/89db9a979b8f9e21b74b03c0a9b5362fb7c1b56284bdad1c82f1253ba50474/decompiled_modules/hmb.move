module 0x7b89db9a979b8f9e21b74b03c0a9b5362fb7c1b56284bdad1c82f1253ba50474::hmb {
    struct HMB has drop {
        dummy_field: bool,
    }

    fun init(arg0: HMB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HMB>(arg0, 6, b"HMB", b"HANBAO", b"The first HANBAO in SUI ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_00_54_39_fcfead47a7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HMB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HMB>>(v1);
    }

    // decompiled from Move bytecode v6
}

