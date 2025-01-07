module 0x7ad64f0a40f16356940c6fd13c1a22c69bd7d036197ce41776d68b31c01171b7::hagi {
    struct HAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: HAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HAGI>(arg0, 9, b"HAGI", b"Rahagi", b"Rahagi token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b6e4ba89-a5ea-4aa9-84dd-cf6a932095b5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HAGI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

