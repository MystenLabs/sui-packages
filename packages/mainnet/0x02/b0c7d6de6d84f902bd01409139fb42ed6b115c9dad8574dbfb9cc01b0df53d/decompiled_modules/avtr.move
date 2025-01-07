module 0x2b0c7d6de6d84f902bd01409139fb42ed6b115c9dad8574dbfb9cc01b0df53d::avtr {
    struct AVTR has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVTR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVTR>(arg0, 6, b"AVTR", b"SUIAVATAR", b"Avatar on this whay last airbender in crypto world ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000196892_37fff915c9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVTR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AVTR>>(v1);
    }

    // decompiled from Move bytecode v6
}

