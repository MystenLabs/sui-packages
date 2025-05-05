module 0xe6214bd7961f92e52b8fac0861dc7aa2a97e55d98f00c14b451a732f3679e251::tru {
    struct TRU has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRU>(arg0, 6, b"TRU", b"NRJJRJJGKTRJR", b"UTTNEMGI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiatsty3wwowv6hioiouv74syoyp32mut2vhl7eallobsqr7mthwaa")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TRU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

