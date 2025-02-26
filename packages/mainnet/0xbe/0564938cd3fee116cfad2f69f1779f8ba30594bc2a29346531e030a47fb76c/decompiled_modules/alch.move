module 0xbe0564938cd3fee116cfad2f69f1779f8ba30594bc2a29346531e030a47fb76c::alch {
    struct ALCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALCH>(arg0, 9, b"ALCH", b"Alchemist AI", b"Alchemist AI is a no-code development platform where users can manifest any idea, dream, or thoughts into a living application.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmYqwkPV1p4DraqN5TfLZVhyrAusSkHfvFDZMJAWALZJxj")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ALCH>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALCH>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALCH>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

