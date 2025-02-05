module 0x5af4a8ebf79da68e47c875b9cfba3973b1ab87eeb72d1e66c9987b66e901e06a::fks {
    struct FKS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FKS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FKS>(arg0, 6, b"FKS", b"FinnyKitty on sui", b"Share ideas and contribute ideas to help FinnyKitty grow stronger.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_02_03_22_24_27_2ed3288354.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FKS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FKS>>(v1);
    }

    // decompiled from Move bytecode v6
}

