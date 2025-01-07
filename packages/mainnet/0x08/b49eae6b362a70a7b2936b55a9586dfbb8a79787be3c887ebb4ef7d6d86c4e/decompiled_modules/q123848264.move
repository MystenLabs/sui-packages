module 0x8b49eae6b362a70a7b2936b55a9586dfbb8a79787be3c887ebb4ef7d6d86c4e::q123848264 {
    struct Q123848264 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q123848264, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q123848264>(arg0, 9, b"Q123848264", b"SASA", b"shshidnndhhxjxd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98cfe2a4-7df2-4e08-9463-3c9c4c0a77e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q123848264>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q123848264>>(v1);
    }

    // decompiled from Move bytecode v6
}

