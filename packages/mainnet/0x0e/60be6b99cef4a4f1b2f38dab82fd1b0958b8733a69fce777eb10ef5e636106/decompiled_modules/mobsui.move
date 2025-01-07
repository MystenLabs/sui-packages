module 0xe60be6b99cef4a4f1b2f38dab82fd1b0958b8733a69fce777eb10ef5e636106::mobsui {
    struct MOBSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOBSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOBSUI>(arg0, 6, b"MOBSUI", b"MobSui", b"The Greatest Whale of all time is coming to the Ocean of Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mobycapa_1772d1dedd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOBSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOBSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

