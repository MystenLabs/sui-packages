module 0x6119b3ad5c24ae9375d8b022aeb41bcd5807aafb31a2808c6e13fecb484ba23f::ricky {
    struct RICKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: RICKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RICKY>(arg0, 9, b"RICKY", b"Ricky kong", b"Rickykong", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c0a430df-f355-4cc0-8081-080a233adad7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RICKY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RICKY>>(v1);
    }

    // decompiled from Move bytecode v6
}

