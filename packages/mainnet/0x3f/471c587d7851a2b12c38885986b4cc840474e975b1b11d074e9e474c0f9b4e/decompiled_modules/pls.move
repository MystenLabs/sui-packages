module 0x3f471c587d7851a2b12c38885986b4cc840474e975b1b11d074e9e474c0f9b4e::pls {
    struct PLS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLS>(arg0, 6, b"PLS", b"Palestine", b"Palestine is a digital token designed to stand against occupation and support freedom and justice for the Palestinian people. Palestine aims to provide necessary support for humanitarian and developmental initiatives striving to end violence and oppression. It is not just a token; it is a global message embodying resilience and dignity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000138834_4f8baa97da.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLS>>(v1);
    }

    // decompiled from Move bytecode v6
}

