module 0xecc3d84b37208afebcd6c7ee4e93a1eb50aa18a496088f08d47ba7edd6c37c10::fncnvm {
    struct FNCNVM has drop {
        dummy_field: bool,
    }

    fun init(arg0: FNCNVM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FNCNVM>(arg0, 9, b"FNCNVM", b"Tsshns", b"Dkdkjd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4f228758-2151-4667-b550-fb80af5da941.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FNCNVM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FNCNVM>>(v1);
    }

    // decompiled from Move bytecode v6
}

