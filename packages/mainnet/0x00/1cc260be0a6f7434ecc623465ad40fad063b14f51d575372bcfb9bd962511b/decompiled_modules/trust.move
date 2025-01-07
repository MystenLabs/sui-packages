module 0x1cc260be0a6f7434ecc623465ad40fad063b14f51d575372bcfb9bd962511b::trust {
    struct TRUST has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUST>(arg0, 9, b"TRUST", b"Dodo", b"Trust dodo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/0e540224-a79d-4fc0-a428-606aa755c383.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUST>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUST>>(v1);
    }

    // decompiled from Move bytecode v6
}

