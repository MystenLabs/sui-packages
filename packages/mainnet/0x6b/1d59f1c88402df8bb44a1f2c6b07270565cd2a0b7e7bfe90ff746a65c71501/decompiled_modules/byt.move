module 0x6b1d59f1c88402df8bb44a1f2c6b07270565cd2a0b7e7bfe90ff746a65c71501::byt {
    struct BYT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BYT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BYT>(arg0, 9, b"BYT", b"MetaByte", b"Every bit is very useful", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imgdlvr.com/pic/photoresizer.com/20240515-6387/public")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BYT>(&mut v2, 10000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BYT>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BYT>>(v1);
    }

    // decompiled from Move bytecode v6
}

