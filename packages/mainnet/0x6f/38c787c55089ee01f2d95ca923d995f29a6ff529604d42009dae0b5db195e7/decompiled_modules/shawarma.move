module 0x6f38c787c55089ee01f2d95ca923d995f29a6ff529604d42009dae0b5db195e7::shawarma {
    struct SHAWARMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHAWARMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHAWARMA>(arg0, 9, b"SHAWARMA", b"SOLOBAZ", b"Normal this thing that everybody can shey you get", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ae8b0fd6-17a0-4e42-b217-b10da90b96c8.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHAWARMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHAWARMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

