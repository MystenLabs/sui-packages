module 0xbf69206c104f00e6850b205f4d45423f68dd0d0c85856319cde0985edc82e38e::birp {
    struct BIRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIRP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIRP>(arg0, 9, b"BIRP", b"BIRP COIN", b"The bird that sings politely, as if following etiquette rules.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c8f4e4c3-76a9-40c4-a655-095033510bae.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIRP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BIRP>>(v1);
    }

    // decompiled from Move bytecode v6
}

