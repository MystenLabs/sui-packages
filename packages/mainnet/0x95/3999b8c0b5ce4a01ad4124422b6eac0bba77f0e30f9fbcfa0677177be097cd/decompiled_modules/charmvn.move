module 0x953999b8c0b5ce4a01ad4124422b6eac0bba77f0e30f9fbcfa0677177be097cd::charmvn {
    struct CHARMVN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARMVN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHARMVN>(arg0, 9, b"CHARMVN", b"CHARM", b"Token for fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9ba62eef-87a6-4065-8217-95457314564d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARMVN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHARMVN>>(v1);
    }

    // decompiled from Move bytecode v6
}

