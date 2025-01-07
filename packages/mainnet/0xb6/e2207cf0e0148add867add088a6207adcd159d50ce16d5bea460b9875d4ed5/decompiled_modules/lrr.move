module 0xb6e2207cf0e0148add867add088a6207adcd159d50ce16d5bea460b9875d4ed5::lrr {
    struct LRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LRR>(arg0, 9, b"LRR", b"Lord Far", b"Lord Farquaad of Memeshire", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/79d3dcf2-0ee9-483c-9577-dfc1c25eb10c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

