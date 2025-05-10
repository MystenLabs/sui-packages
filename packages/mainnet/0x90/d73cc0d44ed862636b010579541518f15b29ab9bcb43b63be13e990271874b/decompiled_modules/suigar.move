module 0x90d73cc0d44ed862636b010579541518f15b29ab9bcb43b63be13e990271874b::suigar {
    struct SUIGAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGAR>(arg0, 6, b"SUIGAR", b"Suigar Pokemon", x"5355494741522069732074686520666972737420706f6b656d6f6e205443472067616d65206f6e20746865200a405375694e6574776f726b", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifozgtv3vbr3fmfqsrliwve4pqs4vdxfch3iqftouy2vfoitvw5oa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIGAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

