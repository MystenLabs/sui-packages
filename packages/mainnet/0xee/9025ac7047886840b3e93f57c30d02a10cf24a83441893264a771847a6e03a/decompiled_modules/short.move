module 0xee9025ac7047886840b3e93f57c30d02a10cf24a83441893264a771847a6e03a::short {
    struct SHORT has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHORT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHORT>(arg0, 6, b"SHORT", b"MrShort", x"4920616d204d722053686f727421204920616d203232616e6420776861742073686f756c64204920646f2077697468206d79206c6966653f0a4920746f6c6420796f75206a75737420627579202453484f5254", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731604008012.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHORT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHORT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

