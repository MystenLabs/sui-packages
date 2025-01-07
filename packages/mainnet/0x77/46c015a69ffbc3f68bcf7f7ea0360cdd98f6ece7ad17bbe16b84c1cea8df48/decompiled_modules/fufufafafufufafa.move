module 0x7746c015a69ffbc3f68bcf7f7ea0360cdd98f6ece7ad17bbe16b84c1cea8df48::fufufafafufufafa {
    struct FUFUFAFAFUFUFAFA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUFUFAFAFUFUFAFA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUFUFAFAFUFUFAFA>(arg0, 6, b"FUFUFAFAFUFUFAFA", b"FUFUFAFA", b"fufufafafufufafafufufafafufufafa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_10_at_18_25_51_a4afe49d98.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUFUFAFAFUFUFAFA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FUFUFAFAFUFUFAFA>>(v1);
    }

    // decompiled from Move bytecode v6
}

