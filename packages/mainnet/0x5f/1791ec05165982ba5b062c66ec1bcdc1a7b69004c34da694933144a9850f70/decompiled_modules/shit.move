module 0x5f1791ec05165982ba5b062c66ec1bcdc1a7b69004c34da694933144a9850f70::shit {
    struct SHIT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHIT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHIT>(arg0, 9, b"SHIT", b"Shitcoin", b"Fart $SHIT, not just another shitcoin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmY28D7tEGRYmuRQgunxvUWeTjMVqwa83pZbibxy9dTLRF")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SHIT>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHIT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHIT>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

