module 0xbda2d3cbc284d16075736ca9ba658ac2b7af3696a47233fcfbcab078daef093f::bt {
    struct BT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BT>(arg0, 9, b"BT", b"bat", b"hgnhn kltjr", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/f98f3c2f9e8fae19e0f904098e01d383blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

