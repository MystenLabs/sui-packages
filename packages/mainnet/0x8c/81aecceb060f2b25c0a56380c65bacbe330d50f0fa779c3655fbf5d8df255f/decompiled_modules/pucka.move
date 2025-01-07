module 0x8c81aecceb060f2b25c0a56380c65bacbe330d50f0fa779c3655fbf5d8df255f::pucka {
    struct PUCKA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUCKA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUCKA>(arg0, 6, b"PUCKA", b"Pucka", b"Im PUCKA, the cutest sheep on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000052176_bd92e54cf0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUCKA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUCKA>>(v1);
    }

    // decompiled from Move bytecode v6
}

