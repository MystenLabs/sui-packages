module 0xb95cd98747c3cc31fc78c4dfd277896ed13b0666f15e84c8cc64f157a0dfb091::pupui {
    struct PUPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPUI>(arg0, 6, b"PUPUI", b"PUPUI ON SUI", b"$PUPUI the blue frog, will be a memeable token from $SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibhdcmznq5d2q77gybk67lf36xikjiqe5nrdvrbsayvu3bth3cs4e")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PUPUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

