module 0x29a9d0e8de519f7191f9293eef533f2606ba129f5caf2aee9056213c737f4f80::suijet {
    struct SUIJET has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIJET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIJET>(arg0, 6, b"SUIJET", b"Jet", b"Jet cat, flying through transactions at supersonic speeds using the power of the Sui Network.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/jet_266301931d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIJET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIJET>>(v1);
    }

    // decompiled from Move bytecode v6
}

