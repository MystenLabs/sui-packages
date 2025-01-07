module 0x455314f7163760c697572e1bd4833f16ecfc37ab441b0eb41c3186d760c370b6::rrr {
    struct RRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: RRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RRR>(arg0, 9, b"RRR", b"EE", b"ASDDAS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8f1f7c0-9ce2-4a68-a048-5f2ee0518213.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

