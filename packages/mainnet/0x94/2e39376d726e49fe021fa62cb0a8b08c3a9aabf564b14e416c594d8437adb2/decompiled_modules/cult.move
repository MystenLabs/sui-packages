module 0x942e39376d726e49fe021fa62cb0a8b08c3a9aabf564b14e416c594d8437adb2::cult {
    struct CULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CULT>(arg0, 6, b"CULT", b"cult", b"cult dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_205214_7eef58c76e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CULT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CULT>>(v1);
    }

    // decompiled from Move bytecode v6
}

