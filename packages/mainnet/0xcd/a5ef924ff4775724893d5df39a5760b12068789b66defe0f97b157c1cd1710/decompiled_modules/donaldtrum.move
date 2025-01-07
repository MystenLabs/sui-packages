module 0xcda5ef924ff4775724893d5df39a5760b12068789b66defe0f97b157c1cd1710::donaldtrum {
    struct DONALDTRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: DONALDTRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DONALDTRUM>(arg0, 9, b"DONALDTRUM", b"H", b"Crypto ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e2ddb5b8-55ba-465e-8443-380fe17989e3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DONALDTRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DONALDTRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

