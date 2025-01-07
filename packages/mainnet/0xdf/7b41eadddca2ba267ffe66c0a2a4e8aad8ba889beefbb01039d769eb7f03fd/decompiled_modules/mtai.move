module 0xdf7b41eadddca2ba267ffe66c0a2a4e8aad8ba889beefbb01039d769eb7f03fd::mtai {
    struct MTAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTAI>(arg0, 9, b"MTAI", b"Meta AI", b"This is a feature for AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/39036b84-2e31-4a65-9f1f-c5d17cef52e7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

