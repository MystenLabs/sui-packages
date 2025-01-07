module 0x8b1369cbbbe2cba8711f9fe15a2b2bc9696da2a4d62ec2f4999da7b19f19a863::dnc {
    struct DNC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DNC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DNC>(arg0, 9, b"DNC", b"Dancer", b"Join the dance tokens by collecting dance tokens  if you love dancing ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82380388-2189-4881-b5b8-5fbdd4ed9228.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DNC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DNC>>(v1);
    }

    // decompiled from Move bytecode v6
}

