module 0x3bf823d12971dec5797444582bc0375384c62065281fa629579b77742ddced87::q123848264 {
    struct Q123848264 has drop {
        dummy_field: bool,
    }

    fun init(arg0: Q123848264, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<Q123848264>(arg0, 9, b"Q123848264", b"SASA", b"shshidnndhhxjxd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b04bf398-51c2-4125-b4ba-15e673202dce.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<Q123848264>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<Q123848264>>(v1);
    }

    // decompiled from Move bytecode v6
}

