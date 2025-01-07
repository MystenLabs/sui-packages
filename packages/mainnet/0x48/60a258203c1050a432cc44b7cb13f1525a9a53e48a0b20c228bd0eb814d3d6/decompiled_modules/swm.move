module 0x4860a258203c1050a432cc44b7cb13f1525a9a53e48a0b20c228bd0eb814d3d6::swm {
    struct SWM has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWM>(arg0, 9, b"SWM", b"Silkworm", b"Small and practical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5117e3b3-a82b-49c2-a480-2ed95b6af5b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SWM>>(v1);
    }

    // decompiled from Move bytecode v6
}

