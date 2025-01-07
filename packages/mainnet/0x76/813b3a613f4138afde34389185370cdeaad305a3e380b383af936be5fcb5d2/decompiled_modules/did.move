module 0x76813b3a613f4138afde34389185370cdeaad305a3e380b383af936be5fcb5d2::did {
    struct DID has drop {
        dummy_field: bool,
    }

    fun init(arg0: DID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DID>(arg0, 9, b"DID", b"Civic ", x"5369636b20616e6420747769737465642070656f706c652077686f20646f6ee280997420", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/73d0f236-5b18-4027-8840-eaafd7222270.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DID>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DID>>(v1);
    }

    // decompiled from Move bytecode v6
}

