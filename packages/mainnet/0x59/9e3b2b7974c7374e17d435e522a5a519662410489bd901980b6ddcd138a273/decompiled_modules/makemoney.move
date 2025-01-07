module 0x599e3b2b7974c7374e17d435e522a5a519662410489bd901980b6ddcd138a273::makemoney {
    struct MAKEMONEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAKEMONEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAKEMONEY>(arg0, 9, b"MAKEMONEY", b"TF INVEST", b"Makemoney ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/ed865209-cbdb-4b74-af59-2269fbaddfad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAKEMONEY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAKEMONEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

