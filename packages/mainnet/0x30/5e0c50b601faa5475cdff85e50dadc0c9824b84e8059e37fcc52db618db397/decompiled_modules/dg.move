module 0x305e0c50b601faa5475cdff85e50dadc0c9824b84e8059e37fcc52db618db397::dg {
    struct DG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DG>(arg0, 9, b"DG", b"Dragon", b"Dragon Ball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/47a04939-e00d-4cd3-b68b-8fe1bbbdb3dd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DG>>(v1);
    }

    // decompiled from Move bytecode v6
}

