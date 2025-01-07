module 0x3b51223181ba104cd87e7fb73989567e76a3ee78555da864b368f4e1af98e57d::mashu {
    struct MASHU has drop {
        dummy_field: bool,
    }

    fun init(arg0: MASHU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MASHU>(arg0, 9, b"MASHU", b"mash", b"fgo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/742172c8-b929-4667-b060-f27bc125d146.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MASHU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MASHU>>(v1);
    }

    // decompiled from Move bytecode v6
}

