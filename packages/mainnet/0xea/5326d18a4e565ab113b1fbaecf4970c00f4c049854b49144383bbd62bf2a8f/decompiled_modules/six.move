module 0xea5326d18a4e565ab113b1fbaecf4970c00f4c049854b49144383bbd62bf2a8f::six {
    struct SIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIX>(arg0, 9, b"SIX", b"Doctor ", b"Doctors are still working ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07568020-7b4f-4dfd-ab5a-f6ece0e5becf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SIX>>(v1);
    }

    // decompiled from Move bytecode v6
}

