module 0xc543809bb30d56a6655fe6a338357c0e2b1c751b671f65a9557f1268db1cc20::kumosui {
    struct KUMOSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KUMOSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KUMOSUI>(arg0, 6, b"KumoSui", b"Kumo TheCatSui", b"MiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiauMiau", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/cap_518bb5afc9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KUMOSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KUMOSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

