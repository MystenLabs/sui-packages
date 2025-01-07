module 0x763aaef45f5e42f3fcf2591054776152051621d2b4ef60713080eeede3ab28d1::vnd {
    struct VND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VND>(arg0, 6, b"VND", b"VUNDIO COIN", b"Start to manage your collectibles on SUI Network. Vundio's sleek design and user-friendly features make the experience enjoyable and efficient. $VND.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_26_23_16_48_d649c86f11.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VND>>(v1);
    }

    // decompiled from Move bytecode v6
}

