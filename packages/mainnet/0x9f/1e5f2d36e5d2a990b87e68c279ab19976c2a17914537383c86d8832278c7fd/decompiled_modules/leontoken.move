module 0x9f1e5f2d36e5d2a990b87e68c279ab19976c2a17914537383c86d8832278c7fd::leontoken {
    struct LEONTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEONTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEONTOKEN>(arg0, 9, b"LEONTOKEN", b"Leomessi", b"Buy and hold I will pump it soon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f6069366-34cb-43d8-b553-b2e887f3766c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEONTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEONTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

