module 0xec4d7b7637de782c7d7175585c33edb9a1a3c096df7ac023ea15535d715ec2cc::suiyan {
    struct SUIYAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIYAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIYAN>(arg0, 6, b"SUIYAN", b"SUPER SUIYAN BLUE", b"Inspired by Goku, powered by SUI. Join the ultimate DeFi dojo. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_26_00_13_19_d4ddb170a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIYAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIYAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

