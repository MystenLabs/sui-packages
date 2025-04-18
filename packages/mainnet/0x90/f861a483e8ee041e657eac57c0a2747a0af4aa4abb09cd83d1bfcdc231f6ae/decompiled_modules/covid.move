module 0x90f861a483e8ee041e657eac57c0a2747a0af4aa4abb09cd83d1bfcdc231f6ae::covid {
    struct COVID has drop {
        dummy_field: bool,
    }

    fun init(arg0: COVID, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COVID>(arg0, 9, b"COVID", b"NEW GOV LAB LEAK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/Qmdo4mKxKd7X6A95RA6PnGQ3BM5g9RZrR1cy9fF8L7wJkG")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<COVID>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<COVID>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COVID>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

