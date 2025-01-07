module 0x8604f8f0f5ae9a61c1f34a1ad016d34487ee0526929cfaf9f052f5b40589c68b::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 6, b"ETH", b"Eel Twisting Habitat", b"eth : eel twisting habitat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_cc15821a16.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

