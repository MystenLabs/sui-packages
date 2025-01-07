module 0x9a715bd54073855c60dcdab71b89d81bca3b53bf865957426e71eb383e86aca6::tch {
    struct TCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: TCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TCH>(arg0, 9, b"TCH", b"40 pieces", b"like a ball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/dd8e335d-9bf8-48ea-ba3f-a494cf423ff4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

