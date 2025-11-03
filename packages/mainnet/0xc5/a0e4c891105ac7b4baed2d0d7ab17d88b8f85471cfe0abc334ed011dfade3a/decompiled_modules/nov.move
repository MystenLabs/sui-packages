module 0xc5a0e4c891105ac7b4baed2d0d7ab17d88b8f85471cfe0abc334ed011dfade3a::nov {
    struct NOV has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOV, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOV>(arg0, 9, b"NOV", b"November", b"Every year it's the same time, November comes, whether you like it or not, it will come anyway and it will be every year.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafkreice2j5xzu7c6extff45op4ksfxvarsgzruhwfsk75ajrdqsipc7gi")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NOV>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOV>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

