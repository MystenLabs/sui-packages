module 0x6a5144078303b1612d5ee2cc69675a2f0830a9526c5a216c2c335605462a61ab::nhu {
    struct NHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: NHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NHU>(arg0, 9, b"NHU", b"NHU CUTE", b"aaaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fb25772-5382-476e-8423-97e747d6da8b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

