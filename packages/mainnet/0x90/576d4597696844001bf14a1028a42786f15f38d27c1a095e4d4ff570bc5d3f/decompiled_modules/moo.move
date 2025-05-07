module 0x90576d4597696844001bf14a1028a42786f15f38d27c1a095e4d4ff570bc5d3f::moo {
    struct MOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOO>(arg0, 6, b"MOO", b"MOORE MOORE", b"Moo... moo? Moo. Moo; what is moo? Moo, perhaps, is not merely sound, but being Moo. Moo: the echo of purpose. Moo! Moo? Moo... moo. Moo is; moo becomes. Moo, as in thought,moo, as in self. Moo... therefore, moo. Moo? Moo! Moo and moo, moo. Moo fr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifsd57eyhsq6s5wjunnchf4n4zxevjtnmmv3k56hxtxgzm2w727ca")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MOO>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

