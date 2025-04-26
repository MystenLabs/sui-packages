module 0xf27c67f22bc22a6ad04a983541088b5780efad4b1af2336c7603304a4215989f::caesar {
    struct CAESAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAESAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAESAR>(arg0, 6, b"CAESAR", b"CAEMOONSUIUS", b"CAESUIUS IS CAESIUS PARODY", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibrqetwgro47xdypoxa4xdqfmqifmrbcsrvgxutlgph5jdz64ockm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAESAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CAESAR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

