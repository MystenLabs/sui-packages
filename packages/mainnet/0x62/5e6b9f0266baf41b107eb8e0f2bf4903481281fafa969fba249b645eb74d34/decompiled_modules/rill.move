module 0x625e6b9f0266baf41b107eb8e0f2bf4903481281fafa969fba249b645eb74d34::rill {
    struct RILL has drop {
        dummy_field: bool,
    }

    fun init(arg0: RILL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RILL>(arg0, 6, b"RILL", b"D", b"Its a drill", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731436092855.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RILL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RILL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

