module 0x84b6b43e62e6021f5b2703a635f2d4c6dba051bf243c90f23051a8e6e40352d2::Lemo {
    struct LEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEMO>(arg0, 6, b"LEMO", b"LEMO on SUI", x"596f75722072656672657368696e6720667269656e6420666f72207468652073756d6d657220f09f988e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeialcnvqyn63xfpqbles7um5jjtxrrkscqc55t2kpfcqprlrbah3aq")), arg1);
        let v2 = v0;
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEMO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<LEMO>>(0x2::coin::mint<LEMO>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LEMO>>(v2);
    }

    // decompiled from Move bytecode v6
}

