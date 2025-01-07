module 0x174b7ec2aba52215b85dad109cf5972f47b98921ac6ac92caa65ba8bd42ce143::wknd {
    struct WKND has drop {
        dummy_field: bool,
    }

    fun init(arg0: WKND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WKND>(arg0, 9, b"WKND", b"bnn", b"dbdb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6228b73a-b4c3-41b7-91b9-a9149bc67283.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WKND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WKND>>(v1);
    }

    // decompiled from Move bytecode v6
}

