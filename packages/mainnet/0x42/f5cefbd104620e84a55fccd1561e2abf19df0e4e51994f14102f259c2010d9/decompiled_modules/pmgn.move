module 0x42f5cefbd104620e84a55fccd1561e2abf19df0e4e51994f14102f259c2010d9::pmgn {
    struct PMGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PMGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PMGN>(arg0, 9, b"PMGN", b"pomegranat", b"Captivating stories about the cultural significance and health benefits of fruit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2e90f1f-c496-4faa-82a3-49351abaf9bd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PMGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PMGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

