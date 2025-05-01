module 0x59044dcd69fdae9ac9cd431ffe7489f16fbd2bf206e279717db5dc1344609428::pou {
    struct POU has drop {
        dummy_field: bool,
    }

    fun init(arg0: POU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POU>(arg0, 6, b"Pou", b"Pou On Sui", b"Pou has arrived on sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/y786e6ms_400x400_0b4f23766d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POU>>(v1);
    }

    // decompiled from Move bytecode v6
}

