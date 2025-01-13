module 0xb54067463a094b3ce1311fec09ac48b09bf5a2e23cb7189a48f4e7a3ba3a8b47::bnb {
    struct BNB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNB>(arg0, 6, b"BNB", b"BNB token", b"BNB on Akasui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/362302fd-acb1-4d6c-a965-6bcfdc7d4d7b.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

