module 0x5fbc014dbe8ebfda9b455eaf55e19d900aca77ae1f276777838e4bf3685f0973::vinex {
    struct VINEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: VINEX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VINEX>(arg0, 9, b"VineX", b"VineX Coin", b"Vine returns, integrating with X, featuring a bold black-and-white logo and rumored to be rebranded as VineX.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmNb7e3Vpc3pJWQR6TfQeFvNSTvoFDGnPmQhmvvQouUby8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<VINEX>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VINEX>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VINEX>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

