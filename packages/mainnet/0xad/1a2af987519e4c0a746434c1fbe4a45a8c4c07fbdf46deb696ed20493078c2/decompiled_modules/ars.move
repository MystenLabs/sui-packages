module 0xad1a2af987519e4c0a746434c1fbe4a45a8c4c07fbdf46deb696ed20493078c2::ars {
    struct ARS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ARS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ARS>(arg0, 9, b"ARS", b"arson", b"arson meme token", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ARS>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ARS>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ARS>>(v1);
    }

    // decompiled from Move bytecode v6
}

