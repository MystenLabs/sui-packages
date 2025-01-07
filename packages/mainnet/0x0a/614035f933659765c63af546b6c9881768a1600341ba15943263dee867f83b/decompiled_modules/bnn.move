module 0xa614035f933659765c63af546b6c9881768a1600341ba15943263dee867f83b::bnn {
    struct BNN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BNN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BNN>(arg0, 6, b"BNN", b"BANANA", b"Everyone loves bananas. Everybody wants bananas. I am a BANANA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732223133068.heic")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BNN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BNN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

