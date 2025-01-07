module 0xb4b6076484ebf37552ebf1548cc79c8957a964cbff2524150887fccc3943e7b6::krabsui {
    struct KRABSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRABSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRABSUI>(arg0, 6, b"KRABSUI", b"KRABS ON SUI", x"546865206d6f7374206f726967696e616c20616e6420626164617373204b726162732c206d61646520666f722074686520535549206e6574776f726b2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/krabs_500_500_f8c695bd9f_fc9a39a403.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRABSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRABSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

