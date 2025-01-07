module 0xa826a94e7b79215dd3bcaa16ee40f1eceea35e222f9373e06859a4134931070c::apus {
    struct APUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: APUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APUS>(arg0, 9, b"APUS", b"APU on SUi", b"Son of PEPE from the Ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e4364fd3-7e95-4fb2-b735-c7d7ecdbe37f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

