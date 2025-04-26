module 0x3af07890efff60f99fb1f3c370a2c5a5c98545fee8ccb912494c33eb783b0c75::nom {
    struct NOM has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOM>(arg0, 9, b"NOM", b"Trust in Nom", b"Tribute to the Bonk Dev and Monke DAO CEO", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sapphire-working-koi-276.mypinata.cloud/ipfs/bafkreihp7pzneso5t56obknhaantjovfl3k7eg4wbt5nuymi2maasn3tz4")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOM>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOM>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

