module 0xf71aafe0a60bfe068b4c1d80364b21a7365fd7227363ce529741edad960110fc::cat20 {
    struct CAT20 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT20, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT20>(arg0, 9, b"CAT20", b"CAT-20", b"OP_CAT on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/26c18945-0266-464a-8465-838e14b45cda.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT20>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT20>>(v1);
    }

    // decompiled from Move bytecode v6
}

