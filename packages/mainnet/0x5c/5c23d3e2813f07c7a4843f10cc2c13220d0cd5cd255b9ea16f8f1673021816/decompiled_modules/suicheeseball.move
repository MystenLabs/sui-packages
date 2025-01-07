module 0x5c5c23d3e2813f07c7a4843f10cc2c13220d0cd5cd255b9ea16f8f1673021816::suicheeseball {
    struct SUICHEESEBALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUICHEESEBALL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUICHEESEBALL>(arg0, 6, b"SUICHEESEBALL", b"CHEESEBALL CAT", b"Cat cheeseball", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3540_688b277fc1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUICHEESEBALL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUICHEESEBALL>>(v1);
    }

    // decompiled from Move bytecode v6
}

