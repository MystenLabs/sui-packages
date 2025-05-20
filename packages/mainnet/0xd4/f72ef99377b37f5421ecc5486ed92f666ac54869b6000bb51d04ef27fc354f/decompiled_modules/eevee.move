module 0xd4f72ef99377b37f5421ecc5486ed92f666ac54869b6000bb51d04ef27fc354f::eevee {
    struct EEVEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: EEVEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EEVEE>(arg0, 9, b"EEVEE", b"Eevee", b"Eevee token - a versatile asset on the Sui blockchain.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreicr4iu66hr66cza4qzpq4ntewafjw3nx3xk3cwbuiyws6ma2amm74")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<EEVEE>(&mut v2, 1000000000000000000, @0x6afca50c06d28a36e5c975d4e2b5de337f68140286598f3fc68d6210008ab628, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EEVEE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EEVEE>>(v1);
    }

    // decompiled from Move bytecode v6
}

