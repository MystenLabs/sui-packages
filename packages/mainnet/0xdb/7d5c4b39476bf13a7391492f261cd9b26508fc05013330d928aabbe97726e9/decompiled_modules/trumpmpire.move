module 0xdb7d5c4b39476bf13a7391492f261cd9b26508fc05013330d928aabbe97726e9::trumpmpire {
    struct TRUMPMPIRE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRUMPMPIRE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRUMPMPIRE>(arg0, 9, b"TRUMPMPIRE", b"Trump Mpir", b"Make America Great Again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/e8a611a2-090d-4eaf-b658-5c2ddad36209.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRUMPMPIRE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPMPIRE>>(v1);
    }

    // decompiled from Move bytecode v6
}

