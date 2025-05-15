module 0x35c08de6959769a9d3932ce23c71fa8c1ed63cdb73835a434b0397808fee1aa8::babinu {
    struct BABINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABINU>(arg0, 6, b"BABINU", b"$Baby Doge inu", b"The cutest Baby Doge on Sui.. every chain needs a $BABINU", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052840_71b0b66da2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

