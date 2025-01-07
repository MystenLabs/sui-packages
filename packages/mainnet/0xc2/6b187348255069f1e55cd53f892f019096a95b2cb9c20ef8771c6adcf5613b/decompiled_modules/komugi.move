module 0xc26b187348255069f1e55cd53f892f019096a95b2cb9c20ef8771c6adcf5613b::komugi {
    struct KOMUGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMUGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMUGI>(arg0, 9, b"KUMOGI", b"Otter Komugi", b"Otter Komugi", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://orange-upper-booby-780.mypinata.cloud/ipfs/QmeYDZKPyFLURJ6YffQVKqzc1ptNzXiQFnpPKc6tAzLqwF"))), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KOMUGI>>(v1);
        0x2::coin::mint_and_transfer<KOMUGI>(&mut v2, 1000000000000000000, @0xf875c1f517cdee5786e9084d75b389551dbad0653499d5976d7aa2989d647b0d, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<KOMUGI>>(v2);
    }

    // decompiled from Move bytecode v6
}

