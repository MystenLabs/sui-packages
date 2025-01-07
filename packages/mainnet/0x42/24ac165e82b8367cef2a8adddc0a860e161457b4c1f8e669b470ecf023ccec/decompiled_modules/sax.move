module 0x4224ac165e82b8367cef2a8adddc0a860e161457b4c1f8e669b470ecf023ccec::sax {
    struct SAX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAX>(arg0, 9, b"SAX", b"SABZI", b"unlimited vegetables", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/07fa3f52-c516-470b-b718-5d088ca68319.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAX>>(v1);
    }

    // decompiled from Move bytecode v6
}

