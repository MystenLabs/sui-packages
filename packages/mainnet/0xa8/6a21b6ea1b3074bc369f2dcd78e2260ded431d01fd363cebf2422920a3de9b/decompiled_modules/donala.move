module 0xa86a21b6ea1b3074bc369f2dcd78e2260ded431d01fd363cebf2422920a3de9b::donala {
    struct DONALA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALA>(arg0, 6, b"DONALA", b"DONALAonSui", x"446f6e616c64202b204b616d616c61203d20444f4e414c416f6e5375692e0a416d65726963612773206661766f7269746520636f75706c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_17_20_26_48_e095388d9d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DONALA>>(v1);
    }

    // decompiled from Move bytecode v6
}

