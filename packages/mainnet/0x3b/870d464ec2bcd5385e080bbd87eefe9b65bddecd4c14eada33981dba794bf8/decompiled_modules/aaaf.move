module 0x3b870d464ec2bcd5385e080bbd87eefe9b65bddecd4c14eada33981dba794bf8::aaaf {
    struct AAAF has drop {
        dummy_field: bool,
    }

    fun init(arg0: AAAF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AAAF>(arg0, 6, b"AAAF", b"AAA Fwog", b"Can't stop won't stop dreaming about Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Your_paragraph_text_70_6ad0f83b5e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AAAF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AAAF>>(v1);
    }

    // decompiled from Move bytecode v6
}

