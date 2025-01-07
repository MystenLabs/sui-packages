module 0xb41e5c74d8834349923221c48ee19de67325ede6a6454c510c2bce1cfac805f9::tt1 {
    struct TT1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: TT1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TT1>(arg0, 9, b"TT1", b"titi", b"TT11", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c311ba23-11ff-4c67-a19b-69200c47ac8a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TT1>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TT1>>(v1);
    }

    // decompiled from Move bytecode v6
}

