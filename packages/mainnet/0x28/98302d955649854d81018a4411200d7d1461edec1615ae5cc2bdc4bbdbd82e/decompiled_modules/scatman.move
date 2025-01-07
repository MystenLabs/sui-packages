module 0x2898302d955649854d81018a4411200d7d1461edec1615ae5cc2bdc4bbdbd82e::scatman {
    struct SCATMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SCATMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SCATMAN>(arg0, 6, b"SCATMAN", b"Scatman On Sui", b"Ski-Ba-Boo-Ba-Dop-Bop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_7857_8db55bb319.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SCATMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SCATMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

