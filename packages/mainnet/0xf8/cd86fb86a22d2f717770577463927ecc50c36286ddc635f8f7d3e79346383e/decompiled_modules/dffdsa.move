module 0xf8cd86fb86a22d2f717770577463927ecc50c36286ddc635f8f7d3e79346383e::dffdsa {
    struct DFFDSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DFFDSA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DFFDSA>(arg0, 9, b"DFFDSA", b"KJHHDF", b"BBCF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9d41aa1a-c7d6-4570-bfd9-7d88787b28d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DFFDSA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DFFDSA>>(v1);
    }

    // decompiled from Move bytecode v6
}

