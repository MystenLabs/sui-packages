module 0x9d56ac4e22aee4a88ad0b6f787dbb7f6de334cb7d42703f0c7452d3afae5dbbd::bom {
    struct BOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOM>(arg0, 9, b"BOM", b"BB", b"Token to the moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80c2eac1-d4bb-45cd-bbf9-46663efc2021.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOM>>(v1);
    }

    // decompiled from Move bytecode v6
}

