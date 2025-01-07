module 0xc74f0c2eb6d8a682211e29adc522654cfdea003ee2da0b20d09e66724dd9ca21::tsg {
    struct TSG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TSG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TSG>(arg0, 8, b"TSG", b"The Great Sui Wolf ", b"Fair launch of The Great Wolf on Sui Network LP has been burned and sent to the burn wallet. Trust no one check it now before you buy TSG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://finbold.com/app/uploads/2023/11/dog.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TSG>(&mut v2, 5000011100000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TSG>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TSG>>(v1);
    }

    // decompiled from Move bytecode v6
}

