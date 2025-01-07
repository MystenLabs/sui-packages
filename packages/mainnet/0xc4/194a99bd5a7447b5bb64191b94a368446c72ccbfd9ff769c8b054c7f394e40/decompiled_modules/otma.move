module 0xc4194a99bd5a7447b5bb64191b94a368446c72ccbfd9ff769c8b054c7f394e40::otma {
    struct OTMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: OTMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OTMA>(arg0, 9, b"OTMA", b"Otmanabuba", b"OTMA token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/bf30b16c-00b8-42c2-8a86-7d3f32f1b5fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OTMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OTMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

