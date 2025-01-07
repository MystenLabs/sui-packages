module 0xe30b22efa91a56f4ccae664d4d3c0ed49bc5def247ff6c28d20121a2494cdb24::weve {
    struct WEVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEVE>(arg0, 9, b"WEVE", b"Hippo", b"Lazy hippo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cdc01f25-6428-495b-a03a-31d5916f9c4a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEVE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

