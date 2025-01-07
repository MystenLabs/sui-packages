module 0x85c5d1c171e9671bce80a9e5e2775d7031483228c844916edf161309280093ad::ven {
    struct VEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: VEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VEN>(arg0, 9, b"VEN", b"Venom", b"Pamp", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ce6e1bda-16fe-4bf3-b448-599ecd08713b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

