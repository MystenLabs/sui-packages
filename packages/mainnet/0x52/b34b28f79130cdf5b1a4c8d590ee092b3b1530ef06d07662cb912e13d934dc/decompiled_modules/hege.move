module 0x52b34b28f79130cdf5b1a4c8d590ee092b3b1530ef06d07662cb912e13d934dc::hege {
    struct HEGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HEGE>(arg0, 6, b"HEGE", b"Hege's Life", x"48656765206973206f6e206120717565737420746f206265636f6d652061207375636365737366756c206d656d6520696e206f7264657220746f2077696e20746865206865617274206f66206869732063727573682c20486567656e612e0a0a4a6f696e207468652024484547452d66756e6420746f2068656c70207475726e2048656765277320647265616d20696e746f207265616c69747921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifemjoemf7ndboljt7lcvpt2vijfjvcnrsoi6al55t5gsuz4f4vfm")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<HEGE>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

