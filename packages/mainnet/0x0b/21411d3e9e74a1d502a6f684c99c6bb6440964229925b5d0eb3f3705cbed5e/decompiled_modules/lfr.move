module 0xb21411d3e9e74a1d502a6f684c99c6bb6440964229925b5d0eb3f3705cbed5e::lfr {
    struct LFR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LFR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LFR>(arg0, 9, b"LFR", b"LONE FORES", b"LONE FOREST TOKEN", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c678e1ca-c66b-4042-b9bc-e46b6e424c94.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LFR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LFR>>(v1);
    }

    // decompiled from Move bytecode v6
}

