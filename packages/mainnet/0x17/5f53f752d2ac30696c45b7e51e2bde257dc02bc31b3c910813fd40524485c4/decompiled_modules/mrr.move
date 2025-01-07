module 0x175f53f752d2ac30696c45b7e51e2bde257dc02bc31b3c910813fd40524485c4::mrr {
    struct MRR has drop {
        dummy_field: bool,
    }

    fun init(arg0: MRR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MRR>(arg0, 9, b"MRR", b"Mirror", b"Mirror on the wall...Here we are again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a8f7083-f320-4486-8a29-1240406aedf1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MRR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MRR>>(v1);
    }

    // decompiled from Move bytecode v6
}

