module 0x56a8280465cbaec66885d7b5127728d2775ac160a7892760ba9f7936c11f8419::sanin {
    struct SANIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SANIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SANIN>(arg0, 6, b"SANIN", b"SANIN THE SUI CHIB", b"SHIB ON ETH ... SANIN ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_design_bc28c3c667.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SANIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SANIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

