module 0x20fd2252d2158db4278f0a6359d3d1bc5ead3f6e29f1539e6323f16622150a53::labrador {
    struct LABRADOR has drop {
        dummy_field: bool,
    }

    fun init(arg0: LABRADOR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LABRADOR>(arg0, 9, b"LABRADOR", b"Labrador", b"A beautiful island and a great friend", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c765b326-23f2-4ec2-b1f1-7c3b1f0f06db.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LABRADOR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LABRADOR>>(v1);
    }

    // decompiled from Move bytecode v6
}

