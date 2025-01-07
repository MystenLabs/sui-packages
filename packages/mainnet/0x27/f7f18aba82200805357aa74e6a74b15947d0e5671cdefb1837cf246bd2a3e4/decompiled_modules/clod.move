module 0x27f7f18aba82200805357aa74e6a74b15947d0e5671cdefb1837cf246bd2a3e4::clod {
    struct CLOD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CLOD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CLOD>(arg0, 6, b"CLOD", b"Clod On Sui", b"Stirring up chaos in the pot, seasoning with a dash of menace. The recipe? Pure mayhem! Brace yourself$CLOD's almost here, and its hungry for destruction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000055112_4e54ba3843.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CLOD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CLOD>>(v1);
    }

    // decompiled from Move bytecode v6
}

