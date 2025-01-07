module 0x87d0b8cfe6f7201ecdb111101aa3a58074cec8b7cfdf31cfce82d7ed907f1412::white {
    struct WHITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: WHITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WHITE>(arg0, 9, b"WHITE", b"Angela White", b"Angela White is the original cute mascot of the Sui blockchain ecosystem", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://6f2859a7-8667-4b05-9978-a8922e29bf1f.selstorage.ru/INST:17841400995730132?time=1719815503")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<WHITE>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WHITE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WHITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

