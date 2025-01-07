module 0xe4c59e81572a05159adfd3304b88e896a24cb8c37a345a4f1f4d297901fd4a8b::mhf {
    struct MHF has drop {
        dummy_field: bool,
    }

    fun init(arg0: MHF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MHF>(arg0, 9, b"MHF", b"GDD", b"Good morning I ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4940050-ed0a-4e40-a7db-242ca7a815fa.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MHF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MHF>>(v1);
    }

    // decompiled from Move bytecode v6
}

