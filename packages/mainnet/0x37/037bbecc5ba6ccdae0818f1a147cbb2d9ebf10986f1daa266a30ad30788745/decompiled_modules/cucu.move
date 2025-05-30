module 0x37037bbecc5ba6ccdae0818f1a147cbb2d9ebf10986f1daa266a30ad30788745::cucu {
    struct CUCU has drop {
        dummy_field: bool,
    }

    fun init(arg0: CUCU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CUCU>(arg0, 6, b"CUCU", b"Cucuonada", b"The only coin that admits what the other pretend not to be", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreidwmzerh64kqiygxo2jjrp6447op45hvcigr2wfrv2q5n7rnfriv4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CUCU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<CUCU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

