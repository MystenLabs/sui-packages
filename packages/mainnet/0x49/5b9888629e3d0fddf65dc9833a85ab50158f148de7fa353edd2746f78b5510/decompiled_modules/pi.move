module 0x495b9888629e3d0fddf65dc9833a85ab50158f148de7fa353edd2746f78b5510::pi {
    struct PI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PI>(arg0, 9, b"PI", b"Pi Network", b"Pi Network is a social cryptocurrency, developer platform, and ecosystem designed for widespread accessibility and real-world utility. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/QmefiRGXBWdtS52qsjo6FzRDoRqyxgdBjN1vzm6XNXtPto")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PI>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PI>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

