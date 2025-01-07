module 0x8c08d03592831ccf536cd16ca645ac36aea324f64cabcd2d9c82933b24f8613f::ghhhh {
    struct GHHHH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GHHHH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GHHHH>(arg0, 9, b"GHHHH", b"Hhhh", b"Kkkhds", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ca30db1a-dc9b-4260-bf27-abbb5a333dfa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GHHHH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GHHHH>>(v1);
    }

    // decompiled from Move bytecode v6
}

