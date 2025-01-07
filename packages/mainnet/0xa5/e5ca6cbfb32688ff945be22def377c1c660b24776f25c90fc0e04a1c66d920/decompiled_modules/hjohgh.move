module 0xa5e5ca6cbfb32688ff945be22def377c1c660b24776f25c90fc0e04a1c66d920::hjohgh {
    struct HJOHGH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HJOHGH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HJOHGH>(arg0, 9, b"HJOHGH", b"Hdhshshs", x"4869c3aa6a6568656865686565", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e6e52d72-1397-42c3-9ef1-3b6d14930051.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HJOHGH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HJOHGH>>(v1);
    }

    // decompiled from Move bytecode v6
}

