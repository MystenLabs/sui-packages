module 0xa625ad3e520ee4a174e3838598d9e9181b41fc142b69eaa2469472c4ef81243e::sas {
    struct SAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAS>(arg0, 6, b"SAS", b"Superior Alpha Status", b"SAS Coin isnt just another crypto this is the coin for those who live unapologetically. SAS stands for Superior Alpha Status of course it does and its here to dominate the crypto space like you dominate your mornings at 4 a.m. while others sle...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiamh6a4jxxllwh3x2ejjvzjbo3qs3srbzhq7kqwijgopguka353ey")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SAS>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

