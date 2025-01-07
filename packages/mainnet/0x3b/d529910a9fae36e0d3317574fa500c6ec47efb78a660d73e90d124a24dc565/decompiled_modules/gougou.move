module 0x3bd529910a9fae36e0d3317574fa500c6ec47efb78a660d73e90d124a24dc565::gougou {
    struct GOUGOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOUGOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOUGOU>(arg0, 9, b"GOUGOU", b"Gou", b"Gou in the teacher said that I would be happy to us your Bitget ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a023b5e3-d58a-455b-ad7f-990a119d42c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOUGOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOUGOU>>(v1);
    }

    // decompiled from Move bytecode v6
}

