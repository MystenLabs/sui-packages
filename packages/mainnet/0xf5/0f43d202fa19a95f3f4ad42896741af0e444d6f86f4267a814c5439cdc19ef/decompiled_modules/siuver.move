module 0xf50f43d202fa19a95f3f4ad42896741af0e444d6f86f4267a814c5439cdc19ef::siuver {
    struct SIUVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIUVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIUVER>(arg0, 6, b"SIUVER", b"SIUVER SURFER", b"Welcome to $SIUVER the Surfer of the sea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/silver_silver_surfer_471f5443a8.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIUVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIUVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

