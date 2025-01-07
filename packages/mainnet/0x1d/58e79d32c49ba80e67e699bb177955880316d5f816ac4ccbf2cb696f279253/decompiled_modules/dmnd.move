module 0x1d58e79d32c49ba80e67e699bb177955880316d5f816ac4ccbf2cb696f279253::dmnd {
    struct DMND has drop {
        dummy_field: bool,
    }

    fun init(arg0: DMND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DMND>(arg0, 6, b"DMND", b"Diamond on SUI", b"Staking shortly after launch. Whitepaper: diamondsui.org/whitepaper.pdf", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/K_Pkx_Mf_A2_400x400_e1f3b89ea3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DMND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DMND>>(v1);
    }

    // decompiled from Move bytecode v6
}

