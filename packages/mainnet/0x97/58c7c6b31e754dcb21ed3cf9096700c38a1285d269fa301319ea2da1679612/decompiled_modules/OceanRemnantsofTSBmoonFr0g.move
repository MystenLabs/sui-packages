module 0x9758c7c6b31e754dcb21ed3cf9096700c38a1285d269fa301319ea2da1679612::OceanRemnantsofTSBmoonFr0g {
    struct OCEANREMNANTSOFTSBMOONFR0G has drop {
        dummy_field: bool,
    }

    fun init(arg0: OCEANREMNANTSOFTSBMOONFR0G, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OCEANREMNANTSOFTSBMOONFR0G>(arg0, 0, b"COS", b"Ocean Remnants of TSBmoonFr0g", b"Weight of the endless, ended, hangs upon your shoulders.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Wings_Ocean_Remnants_of_TSBmoonFr0g.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OCEANREMNANTSOFTSBMOONFR0G>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OCEANREMNANTSOFTSBMOONFR0G>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

