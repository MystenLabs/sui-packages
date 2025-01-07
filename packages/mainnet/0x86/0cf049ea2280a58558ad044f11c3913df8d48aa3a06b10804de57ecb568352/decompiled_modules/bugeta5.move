module 0x860cf049ea2280a58558ad044f11c3913df8d48aa3a06b10804de57ecb568352::bugeta5 {
    struct BUGETA5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUGETA5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUGETA5>(arg0, 9, b"BUGETA5", b"BUGETA", b"BUGATA DOGDE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fe36f46d-b504-4498-917b-b9fa8bc8c4f8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUGETA5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BUGETA5>>(v1);
    }

    // decompiled from Move bytecode v6
}

