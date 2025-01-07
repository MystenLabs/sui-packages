module 0x1f24f0fc6f0f24d834ba8042da2983345b9ce42e892e60d5b4bb8f0f49c029df::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLA>(arg0, 9, b"TESLA", b"Mr Tesla", b"Nicolas Tesla on Blockchain ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5cabdee6-024d-45bb-a8a7-6393a84205de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TESLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

