module 0x979d157d084fccec79770f19ad113cc686ab9266c522f23f19bcd1016be085d0::suisex {
    struct SUISEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISEX>(arg0, 6, b"SuiSex", b"Sui Sex", b"The Number 1 Sui Sex site for sui rewards", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suisex11_4f5afab0d3.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISEX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISEX>>(v1);
    }

    // decompiled from Move bytecode v6
}

