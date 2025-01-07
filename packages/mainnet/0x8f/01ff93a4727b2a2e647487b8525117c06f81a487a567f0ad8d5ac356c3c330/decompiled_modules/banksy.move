module 0x8f01ff93a4727b2a2e647487b8525117c06f81a487a567f0ad8d5ac356c3c330::banksy {
    struct BANKSY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BANKSY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BANKSY>(arg0, 6, b"BANKSY", b"Banksy on SUI", x"4a6f696e20546865204d6f76656d656e740a2442414e4b5359206f6e20535549", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Hzw7_J_Guf_400x400_20ad5813de.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BANKSY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BANKSY>>(v1);
    }

    // decompiled from Move bytecode v6
}

