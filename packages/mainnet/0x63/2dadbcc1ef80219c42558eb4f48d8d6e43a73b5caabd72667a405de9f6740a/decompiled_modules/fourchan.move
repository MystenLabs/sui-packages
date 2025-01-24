module 0x632dadbcc1ef80219c42558eb4f48d8d6e43a73b5caabd72667a405de9f6740a::fourchan {
    struct FOURCHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOURCHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOURCHAN>(arg0, 9, b"FOURCHAN", b"4chan on Sui", b"The original forum.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmRp5TADnDo6VKPtAXM6bJz9TDRVWyZNhbrwRw7bXHEshV")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FOURCHAN>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOURCHAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOURCHAN>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

