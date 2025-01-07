module 0x7bc0e0a4f8ac67181fbdc8d856be63cd48ce199584950f1079f2acf97bab3d68::stokk {
    struct STOKK has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOKK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STOKK>(arg0, 6, b"STokk", b"S Tokken", b"S Token: the superhero of cryptocurrencies! Fast as a cheetah, secure as a safe and with rewards so tasty you'll think you're at the buffet! Join us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000013691_cafb01b879.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOKK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOKK>>(v1);
    }

    // decompiled from Move bytecode v6
}

