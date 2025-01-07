module 0xb7ab4ea072c110399542e60fe6d40d84cbca4151b115e2dafc649728cfceaa76::mts {
    struct MTS has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTS>(arg0, 9, b"MTS", b"Motor-sui", b"Motor's passion on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2c48350f-0ae4-41c0-b29a-6b1d414a407d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTS>>(v1);
    }

    // decompiled from Move bytecode v6
}

