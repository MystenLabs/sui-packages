module 0xb0d08b0ebd8ca345e5494e804fc6f936473797f12156875bbd905ea514fe45f6::kcoa {
    struct KCOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KCOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KCOA>(arg0, 9, b"KCOA", b"Kecoa", b"Kecoa terbang", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5549b933-c491-4448-9687-36ceed95a075.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KCOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KCOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

