module 0xc10898608a2af1e6dba0b224e77354974f3c8c2fe6b23f389830048c2e0141b6::cary {
    struct CARY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CARY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CARY>(arg0, 9, b"CARY", b"CAT CRY", b"meow meow meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a804e95f-0d60-4fce-b8dc-f92d0587494b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CARY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CARY>>(v1);
    }

    // decompiled from Move bytecode v6
}

