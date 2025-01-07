module 0xfdd60fc5a36f87733e952963cab90d38626809fabf47a72aaa48fa13f1c32a88::daisy {
    struct DAISY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAISY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DAISY>(arg0, 6, b"Daisy", b"Daisy Dukes", b"Daisy Dukes the mini pig", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/daisy_3ea526bbf9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAISY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAISY>>(v1);
    }

    // decompiled from Move bytecode v6
}

