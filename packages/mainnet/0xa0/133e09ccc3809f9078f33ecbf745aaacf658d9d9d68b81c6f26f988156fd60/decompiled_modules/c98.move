module 0xa0133e09ccc3809f9078f33ecbf745aaacf658d9d9d68b81c6f26f988156fd60::c98 {
    struct C98 has drop {
        dummy_field: bool,
    }

    fun init(arg0: C98, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<C98>(arg0, 9, b"C98", b"Chia 98", b"Chia 98 lan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/aff6c219-c83b-40fe-a36b-0d185746c070.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C98>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<C98>>(v1);
    }

    // decompiled from Move bytecode v6
}

