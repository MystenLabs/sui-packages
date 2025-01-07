module 0x2ca5c0ff30ca777ccfee904598e219f18648f6ec12d417a9454a766d93f75923::woodang {
    struct WOODANG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WOODANG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WOODANG>(arg0, 6, b"WOODANG", b"Hippo dance water", b"Too large to care, too smooth to stop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_11_003523_00626ebe77.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WOODANG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WOODANG>>(v1);
    }

    // decompiled from Move bytecode v6
}

