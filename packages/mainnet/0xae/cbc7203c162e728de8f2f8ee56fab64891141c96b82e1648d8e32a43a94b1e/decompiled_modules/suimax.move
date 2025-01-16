module 0xaecbc7203c162e728de8f2f8ee56fab64891141c96b82e1648d8e32a43a94b1e::suimax {
    struct SUIMAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAX>(arg0, 6, b"SuiMAX", b"Sui MAX", b"step by step to the goal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000020169_d57d03e39e.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

