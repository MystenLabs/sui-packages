module 0x3e643677d743fa55a77e3fe01b1992d02bff6f67358e5ab1a8c49e39cb8617f2::zxc {
    struct ZXC has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZXC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZXC>(arg0, 9, b"zxcs", b"zxc", b"zxczxczxc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://coinhublogos.9inch.io/1724653538838-chum.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZXC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZXC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

