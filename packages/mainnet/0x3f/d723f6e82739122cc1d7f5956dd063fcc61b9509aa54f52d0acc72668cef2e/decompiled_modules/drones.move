module 0x3fd723f6e82739122cc1d7f5956dd063fcc61b9509aa54f52d0acc72668cef2e::drones {
    struct DRONES has drop {
        dummy_field: bool,
    }

    fun init(arg0: DRONES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DRONES>(arg0, 6, b"Drones", b"SkyNet Drones on Sui", b"They move in perfect formation. Their origins unknown, their purpose unclear. As sightings multiply across the Garden State, one thing becomes certain: we are not alone in monitoring our skies. Join the investigation. Track the signals.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1734656269959.25")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DRONES>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DRONES>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

