module 0x2dc7cb7ab5cd2eddf0475a6718b3a81bc73433ac15b30f024345e111408ca27f::kawa {
    struct KAWA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KAWA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KAWA>(arg0, 9, b"KAWA", b"KawaOnSui", b"Kawa Coin on the SUI chain enables seamless, secure transactions and liquidity, flowing like a river through the blockchain ecosystem.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3abeb8bd-b1bb-42fe-bca8-44a16770fd1e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KAWA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KAWA>>(v1);
    }

    // decompiled from Move bytecode v6
}

