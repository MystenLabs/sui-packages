module 0x642d987e7d3614ed90242a450f1c8eb15169c1c136b6eb23f7d3264b5e2e1b47::afsui {
    struct AFSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AFSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AFSUI>(arg0, 6, b"Afsui", b"Aftermath", x"5468652041676772656761746f72206f662041676772656761746f72730a41667465726d617468206c6f6f6b7320666f7220746865206265737420726f75746520666f7220796f757220747261646520616d6f6e6720612076617269657479206f66204465782041676772656761746f72732c2066696e64696e6720796f7520746865206265737420657865637574696f6e20707269636573206f6e205375692e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000150549_590801ffca.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AFSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AFSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

