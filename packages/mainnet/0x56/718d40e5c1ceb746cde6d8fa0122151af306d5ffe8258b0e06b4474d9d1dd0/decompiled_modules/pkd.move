module 0x56718d40e5c1ceb746cde6d8fa0122151af306d5ffe8258b0e06b4474d9d1dd0::pkd {
    struct PKD has drop {
        dummy_field: bool,
    }

    fun init(arg0: PKD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PKD>(arg0, 9, b"PKD", b"Pink drago", b"this is a cute pink dragon take care of it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fd2acc48-6dca-42c8-b0b8-f43784301953.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PKD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PKD>>(v1);
    }

    // decompiled from Move bytecode v6
}

