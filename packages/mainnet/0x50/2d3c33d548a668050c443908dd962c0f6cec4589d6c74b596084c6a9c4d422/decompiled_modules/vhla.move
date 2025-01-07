module 0x502d3c33d548a668050c443908dd962c0f6cec4589d6c74b596084c6a9c4d422::vhla {
    struct VHLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: VHLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VHLA>(arg0, 6, b"Vhla", b"Valhala", b"Valhalla awaits", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_6724_b4b8225020.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VHLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VHLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

