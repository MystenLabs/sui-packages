module 0x16684baed3ec2f6f71afea5d2c632ec648104830c381125339684131aab4d6f1::gpoa {
    struct GPOA has drop {
        dummy_field: bool,
    }

    fun init(arg0: GPOA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GPOA>(arg0, 9, b"GPOA", b"Temitope O", b"Business token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f08fc510-b0c9-4350-9f91-28c4a38db361.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GPOA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GPOA>>(v1);
    }

    // decompiled from Move bytecode v6
}

