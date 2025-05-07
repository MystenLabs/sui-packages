module 0x2d3b451d490601e54dd1988d1b06335e86132ac75fd5a5871cc067f1222bb2bc::noo {
    struct NOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOO>(arg0, 9, b"NOO", b"No office", b"this only airdrop", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/e40629214ee551bf037fc81fbb1a3730blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

