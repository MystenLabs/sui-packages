module 0xba2d5ba376cdd2eab4ebc78108e95176b275061dc87578b02a0c4608cdb8704b::bluekachusui {
    struct BLUEKACHUSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEKACHUSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEKACHUSUI>(arg0, 6, b"BluekachuSui", b"Bluekachu Sui", b"BluekachuSui caoo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifcfhbnu2tklvkg3wbvldirlnljdwp7qxukwhlia6hpdsihkcjboe")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEKACHUSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLUEKACHUSUI>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

