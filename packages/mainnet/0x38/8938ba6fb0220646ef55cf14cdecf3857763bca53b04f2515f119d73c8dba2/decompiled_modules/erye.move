module 0x388938ba6fb0220646ef55cf14cdecf3857763bca53b04f2515f119d73c8dba2::erye {
    struct ERYE has drop {
        dummy_field: bool,
    }

    fun init(arg0: ERYE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ERYE>(arg0, 9, b"ERYE", b"YWRE", b"YERY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/829030e4-4494-4755-a7ed-29715770751a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ERYE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ERYE>>(v1);
    }

    // decompiled from Move bytecode v6
}

