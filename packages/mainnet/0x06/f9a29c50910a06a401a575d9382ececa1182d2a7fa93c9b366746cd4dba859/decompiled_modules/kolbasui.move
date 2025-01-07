module 0x6f9a29c50910a06a401a575d9382ececa1182d2a7fa93c9b366746cd4dba859::kolbasui {
    struct KOLBASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOLBASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOLBASUI>(arg0, 6, b"KOLBASUI", b"KOLBASUI", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images-prod.healthline.com/hlcmsresource/images/AN_images/healthiest-cheese-1296x728-swiss.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KOLBASUI>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOLBASUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOLBASUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

