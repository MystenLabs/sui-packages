module 0xbdec4dad513e350d31fc048a700ab5f4757824a414fb16fd72bbe45d9c15093a::td92d6500 {
    struct TD92D6500 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TD92D6500>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TD92D6500>>(0x2::coin::mint<TD92D6500>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TD92D6500, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TD92D6500>(arg0, 9, b"TRX", b"TRX", b"TRX", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.postimg.cc/N0BWnTz5/photo-2026-02-25-21-34-04.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TD92D6500>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TD92D6500>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

