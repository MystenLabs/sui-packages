module 0x8e98ff3840af25b1ddd9ff23b9be7b56a3b157c8c331d9a2055af0a0fa150b60::ivank {
    struct IVANK has drop {
        dummy_field: bool,
    }

    fun init(arg0: IVANK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IVANK>(arg0, 9, b"Ivank", b"Ivanka Trump", b"Ivanka Trump baby daughter D.C", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRcFvnexRt6gDDJQt66DodLkKNNJw6UvBeuAZ2efGKcf8")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<IVANK>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IVANK>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IVANK>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

