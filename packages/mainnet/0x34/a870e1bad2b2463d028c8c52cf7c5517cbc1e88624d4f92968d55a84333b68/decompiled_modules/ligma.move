module 0x34a870e1bad2b2463d028c8c52cf7c5517cbc1e88624d4f92968d55a84333b68::ligma {
    struct LIGMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIGMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIGMA>(arg0, 9, b"LIGMA", b"Ligma???", b"Ligmaballs", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/58defc11-9f2e-46fc-a497-7433888602cc.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIGMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LIGMA>>(v1);
    }

    // decompiled from Move bytecode v6
}

