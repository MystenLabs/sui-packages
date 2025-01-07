module 0xfd58d2962c1b2d3e53427cd88d57d162f28fd873dba12c4a1a6dc442f7fcc50a::zimmm {
    struct ZIMMM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZIMMM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZIMMM>(arg0, 9, b"ZIMMM", b"ZimmermanN", b"Zim Coin ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08068596-ad34-44c6-ba33-e2829b996be9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZIMMM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZIMMM>>(v1);
    }

    // decompiled from Move bytecode v6
}

