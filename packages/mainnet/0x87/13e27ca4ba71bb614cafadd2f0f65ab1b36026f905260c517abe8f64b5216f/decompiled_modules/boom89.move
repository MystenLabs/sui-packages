module 0x8713e27ca4ba71bb614cafadd2f0f65ab1b36026f905260c517abe8f64b5216f::boom89 {
    struct BOOM89 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOM89, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOOM89>(arg0, 9, b"BOOM89", b"boom", b"rich", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd3f71c7-c7c3-4d08-a7bf-8de3ad7eea29.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOM89>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOM89>>(v1);
    }

    // decompiled from Move bytecode v6
}

