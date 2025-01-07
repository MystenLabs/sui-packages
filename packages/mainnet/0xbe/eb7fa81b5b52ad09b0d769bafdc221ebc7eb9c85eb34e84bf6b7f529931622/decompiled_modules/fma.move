module 0xbeeb7fa81b5b52ad09b0d769bafdc221ebc7eb9c85eb34e84bf6b7f529931622::fma {
    struct FMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FMA>(arg0, 9, b"FMA", b"Fatema", b"Fmatoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b1be0f66-de8f-444f-bfc9-236ed1ace52e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

