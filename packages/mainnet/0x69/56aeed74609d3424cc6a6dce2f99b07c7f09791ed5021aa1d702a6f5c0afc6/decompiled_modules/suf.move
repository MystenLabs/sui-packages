module 0x6956aeed74609d3424cc6a6dce2f99b07c7f09791ed5021aa1d702a6f5c0afc6::suf {
    struct SUF has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUF>(arg0, 9, b"SUF", b"SUIflash", b"Depict the speed and scalability of SUI blockcain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/4e1e09dd-2f5b-4b9e-8fa5-69fa012f43e0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUF>>(v1);
    }

    // decompiled from Move bytecode v6
}

