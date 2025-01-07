module 0x7b9b0d174c4448c9587b4177f6d21cec445f3d9f138bb6fb29617f900ed664c6::afhbbbb {
    struct AFHBBBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFHBBBB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFHBBBB>(arg0, 9, b"AFHBBBB", b"hjkkpkfjrj", b"brnnrhnrnrnrnrn", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1f0ca887-4577-47b9-8aab-4499c1ab1397.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFHBBBB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AFHBBBB>>(v1);
    }

    // decompiled from Move bytecode v6
}

