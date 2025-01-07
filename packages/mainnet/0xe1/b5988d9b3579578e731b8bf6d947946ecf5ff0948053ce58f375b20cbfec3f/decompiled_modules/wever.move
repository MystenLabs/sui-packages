module 0xe1b5988d9b3579578e731b8bf6d947946ecf5ff0948053ce58f375b20cbfec3f::wever {
    struct WEVER has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEVER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WEVER>(arg0, 9, b"WEVER", b"wever", b"always on thing about sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3a7f501e-3998-4835-83ad-516e0653aeeb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEVER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WEVER>>(v1);
    }

    // decompiled from Move bytecode v6
}

