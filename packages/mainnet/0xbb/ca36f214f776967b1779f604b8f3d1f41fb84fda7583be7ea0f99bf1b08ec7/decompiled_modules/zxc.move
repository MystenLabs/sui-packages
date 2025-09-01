module 0xbbca36f214f776967b1779f604b8f3d1f41fb84fda7583be7ea0f99bf1b08ec7::zxc {
    struct ZXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXC>(arg0, 6, b"ZXC", b"ZXC", b"undefined", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"undefined"))), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXC>>(v1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ZXC>(&mut v2, 100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXC>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

