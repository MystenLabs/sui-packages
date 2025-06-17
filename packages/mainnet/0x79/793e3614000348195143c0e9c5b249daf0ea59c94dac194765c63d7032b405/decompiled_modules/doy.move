module 0x79793e3614000348195143c0e9c5b249daf0ea59c94dac194765c63d7032b405::doy {
    struct DOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOY>(arg0, 6, b"DOY", b"DOY WAR", b"DOY WAR FIGHT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihuc3fpa52bvrt3ifnbqfopbgvgtakqbmvregkgw4iio7x4ihogva")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DOY>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

