module 0x8fe4d5b9fb7948c4c173ed9ac7a7de9d0d1c3ca78b726d848437ae3a30b78367::angrydog {
    struct ANGRYDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGRYDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGRYDOG>(arg0, 6, b"ANGRYDOG", b"AngryDogOnSui", b"Angrydog are everywhere dog angry and Sui is no exception. They pump, float, and boil  they're fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001064_780c28c71b.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGRYDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGRYDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

