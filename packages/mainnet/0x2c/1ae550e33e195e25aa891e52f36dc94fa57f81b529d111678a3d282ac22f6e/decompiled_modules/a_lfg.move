module 0x2c1ae550e33e195e25aa891e52f36dc94fa57f81b529d111678a3d282ac22f6e::a_lfg {
    struct A_LFG has drop {
        dummy_field: bool,
    }

    fun init(arg0: A_LFG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<A_LFG>(arg0, 9, b"A_LFG", b"dnvvgjyp", b"dnvvgjyp is good cryptoer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/ebf237a911b43948f74a66b0c853cfd0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<A_LFG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<A_LFG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

