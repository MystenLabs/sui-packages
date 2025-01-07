module 0xb82179d4feed5a2bdb7e68aaf5e220f99f9bc5af9da743255f7474001063687a::ste {
    struct STE has drop {
        dummy_field: bool,
    }

    fun init(arg0: STE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STE>(arg0, 9, b"STE", b"street", b"wide and wide", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/939cbe4a-51cc-4c9d-8340-f67f3440e5eb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STE>>(v1);
    }

    // decompiled from Move bytecode v6
}

