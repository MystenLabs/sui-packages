module 0x1c26b749393819762ad6ffb65692eac4a281f161d3a84302c507297e016fcae3::nkeni_1 {
    struct NKENI_1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NKENI_1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NKENI_1>(arg0, 9, b"NKENI_1", b"Phil ", b"Creating wealth to make life easier for my love ones ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f9729df3-0c0f-4d88-8ae7-46de289e4532.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NKENI_1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NKENI_1>>(v1);
    }

    // decompiled from Move bytecode v6
}

