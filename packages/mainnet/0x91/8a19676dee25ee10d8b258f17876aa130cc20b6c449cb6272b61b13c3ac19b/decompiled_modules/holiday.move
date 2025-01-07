module 0x918a19676dee25ee10d8b258f17876aa130cc20b6c449cb6272b61b13c3ac19b::holiday {
    struct HOLIDAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLIDAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOLIDAY>(arg0, 9, b"HOLIDAY", b"@Holiday@", b"Holiday Token", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30b0736c-20e6-4665-b171-7389a1fa9ebb.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLIDAY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOLIDAY>>(v1);
    }

    // decompiled from Move bytecode v6
}

