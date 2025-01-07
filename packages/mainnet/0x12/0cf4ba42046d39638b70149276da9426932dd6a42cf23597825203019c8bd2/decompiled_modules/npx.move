module 0x120cf4ba42046d39638b70149276da9426932dd6a42cf23597825203019c8bd2::npx {
    struct NPX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NPX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NPX>(arg0, 9, b"NPX", b"notp", b"NPX3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c7ca6c1c-f8c3-4ce9-a14b-3e6ba7f9c745.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NPX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NPX>>(v1);
    }

    // decompiled from Move bytecode v6
}

