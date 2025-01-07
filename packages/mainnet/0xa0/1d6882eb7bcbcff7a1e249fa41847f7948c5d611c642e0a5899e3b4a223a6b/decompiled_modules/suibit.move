module 0xa01d6882eb7bcbcff7a1e249fa41847f7948c5d611c642e0a5899e3b4a223a6b::suibit {
    struct SUIBIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBIT>(arg0, 6, b"SUIBIT", b"Thesuibit", b"Meet SUIBIT, a memecoin with the best ticker you'll ever see on sui blockchain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053668_20af65f56e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

