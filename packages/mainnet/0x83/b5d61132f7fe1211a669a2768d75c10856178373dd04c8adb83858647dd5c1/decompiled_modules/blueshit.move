module 0x83b5d61132f7fe1211a669a2768d75c10856178373dd04c8adb83858647dd5c1::blueshit {
    struct BLUESHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUESHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUESHIT>(arg0, 6, b"BLUESHIT", b"Blue Shitcoin", b"Original Blue Shit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/NA_vtelen_f1a1eb527f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUESHIT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUESHIT>>(v1);
    }

    // decompiled from Move bytecode v6
}

