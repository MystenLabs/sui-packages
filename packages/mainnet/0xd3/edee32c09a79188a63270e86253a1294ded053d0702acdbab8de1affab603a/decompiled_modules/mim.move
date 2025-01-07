module 0xd3edee32c09a79188a63270e86253a1294ded053d0702acdbab8de1affab603a::mim {
    struct MIM has drop {
        dummy_field: bool,
    }

    fun init(arg0: MIM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MIM>(arg0, 9, b"MIM", b"Mimi", b"Mimmmm", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/18d43d0a-59fd-4498-a66f-587199efd545.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MIM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MIM>>(v1);
    }

    // decompiled from Move bytecode v6
}

