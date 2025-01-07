module 0x3062ea1da7201717d8fc8f77ea00ceda04e4ffea8a26e350d6d18bbcd06be17f::ironyman {
    struct IRONYMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: IRONYMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<IRONYMAN>(arg0, 6, b"Ironyman", b"Elon Musk", x"417320746865206b696e67206f66206d656d65207477656574656420224920616d2049726f6e796d616e22200af09f92aa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732420134317.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<IRONYMAN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IRONYMAN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

