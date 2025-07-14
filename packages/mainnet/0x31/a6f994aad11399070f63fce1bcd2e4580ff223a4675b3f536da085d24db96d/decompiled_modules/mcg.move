module 0x31a6f994aad11399070f63fce1bcd2e4580ff223a4675b3f536da085d24db96d::mcg {
    struct MCG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MCG>(arg0, 6, b"McG", b"McGregor", x"244d634720746865206e6577204d63446f6e616c64c2b473206d656e752073706f6e736f7265642062792074686520666972737420646f75626c65206368616d70696f6e20696e2055464320686973746f7279", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreihkev5iujuoi4r22eohwjy46ktub7orixe3l56zrvrsv4mvqh2ggy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MCG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

