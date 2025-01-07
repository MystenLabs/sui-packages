module 0x2a892353f452ed33fae6400441077e626d442af00f68612f66152b0e0ef130c7::villain01 {
    struct VILLAIN01 has drop {
        dummy_field: bool,
    }

    fun init(arg0: VILLAIN01, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VILLAIN01>(arg0, 9, b"VILLAIN01", b"Villains", b"Fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6fda42fc-f48c-4654-af41-f2fe4914f391.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VILLAIN01>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VILLAIN01>>(v1);
    }

    // decompiled from Move bytecode v6
}

