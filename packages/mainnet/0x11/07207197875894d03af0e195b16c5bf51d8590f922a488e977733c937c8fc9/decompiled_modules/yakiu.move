module 0x1107207197875894d03af0e195b16c5bf51d8590f922a488e977733c937c8fc9::yakiu {
    struct YAKIU has drop {
        dummy_field: bool,
    }

    fun init(arg0: YAKIU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YAKIU>(arg0, 6, b"Yakiu", b"Japanese Pepe", b"Yakiu  Japanese Pepe", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifkdm3qolsv2ps7qfn5wd56vfrxxm3wtbaefbjjxhls746gngm3qy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YAKIU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YAKIU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

