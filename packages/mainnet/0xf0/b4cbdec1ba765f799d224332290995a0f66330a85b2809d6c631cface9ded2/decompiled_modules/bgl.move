module 0xf0b4cbdec1ba765f799d224332290995a0f66330a85b2809d6c631cface9ded2::bgl {
    struct BGL has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGL>(arg0, 6, b"BGL", b"BiggleLove", b"We curate love articles, activities and events and share with everyone interested. Join us", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1738833838477.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BGL>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGL>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

