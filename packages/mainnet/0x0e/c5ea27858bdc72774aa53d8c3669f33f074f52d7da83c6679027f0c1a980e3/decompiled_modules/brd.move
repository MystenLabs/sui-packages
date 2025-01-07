module 0xec5ea27858bdc72774aa53d8c3669f33f074f52d7da83c6679027f0c1a980e3::brd {
    struct BRD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRD>(arg0, 6, b"BRD", b"BurnDonald", b"BurnDonald Will burn token step by step", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000004695_05be46c905.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRD>>(v1);
    }

    // decompiled from Move bytecode v6
}

