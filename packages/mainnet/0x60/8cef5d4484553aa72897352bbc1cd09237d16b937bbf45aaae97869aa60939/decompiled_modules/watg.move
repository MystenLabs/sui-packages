module 0x608cef5d4484553aa72897352bbc1cd09237d16b937bbf45aaae97869aa60939::watg {
    struct WATG has drop {
        dummy_field: bool,
    }

    fun init(arg0: WATG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WATG>(arg0, 9, b"WATG", b"Warthog", b"New coin with many opportunities ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/3f447df1-bdea-41db-81a1-8b9fa4801085.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WATG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WATG>>(v1);
    }

    // decompiled from Move bytecode v6
}

