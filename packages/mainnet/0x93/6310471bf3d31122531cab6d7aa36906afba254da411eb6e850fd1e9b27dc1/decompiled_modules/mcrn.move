module 0x936310471bf3d31122531cab6d7aa36906afba254da411eb6e850fd1e9b27dc1::mcrn {
    struct MCRN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCRN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCRN>(arg0, 6, b"MCRN", b"Macaronna", b"Macaronna good", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://beige-abstract-pig-256.mypinata.cloud/ipfs/bafkreifb3dezebpulqfuoewhy6sdpcga7mnp3hdd2nlegidlyeuwmnnn2u")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCRN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCRN>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

