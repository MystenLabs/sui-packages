module 0xf44f265c20b6d27c3d95f417d58241c3baa67eee7a0d3ade85d3432cbea4284f::smwma {
    struct SMWMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SMWMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SMWMA>(arg0, 9, b"SMWMA", b"Oakwjwnw", b"Amama", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b969c35e-c995-4454-b2f4-fa6048f2e035.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SMWMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SMWMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

