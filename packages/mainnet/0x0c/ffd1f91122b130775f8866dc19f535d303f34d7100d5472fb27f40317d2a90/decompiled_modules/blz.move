module 0xcffd1f91122b130775f8866dc19f535d303f34d7100d5472fb27f40317d2a90::blz {
    struct BLZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLZ>(arg0, 9, b"BLZ", b"BLISSFUL ", b"Great feeling", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df5354ba-892e-41b5-8021-e836ce3a49a5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

