module 0xf65d3a799164d192e14c7e87fb9f0930535e5f76dd641ea239471222039386d2::sdr {
    struct SDR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDR>(arg0, 9, b"SDR", b"STONE", b"STONEISSS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8c5406b3-da03-4d39-a339-262287fe05c2.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SDR>>(v1);
    }

    // decompiled from Move bytecode v6
}

