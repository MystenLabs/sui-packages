module 0x32dc943a697cf92bad93a32c103a5bb3b993868d1b9434c357e68aedcd99e1fe::sboxdao {
    struct SBOXDAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBOXDAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBOXDAO>(arg0, 9, b"SBOXDAO", b"SUIBoxer Community ", b"SUIBoxer Community is not just a community but a powerful investment fund dedicated to discovering and supporting high-potential projects within the SUI ecosystem. Our mission is to accelerate the growth of SUI Blockchain by providing funding, strategic connections, and expert support to outstanding projects, helping them expand and thrive in the market.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/7fc275c0-df6b-11ef-bca4-c345b724baef")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SBOXDAO>>(v1);
        0x2::coin::mint_and_transfer<SBOXDAO>(&mut v2, 1100000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBOXDAO>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

