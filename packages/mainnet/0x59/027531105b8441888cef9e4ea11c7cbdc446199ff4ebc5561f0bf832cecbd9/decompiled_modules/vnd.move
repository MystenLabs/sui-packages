module 0x59027531105b8441888cef9e4ea11c7cbdc446199ff4ebc5561f0bf832cecbd9::vnd {
    struct VND has drop {
        dummy_field: bool,
    }

    fun init(arg0: VND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<VND>(arg0, 6, b"VND", b"VUNDIO", b"Start to manage your collectibles on SUI Network. Vundio's sleek design and user-friendly features make the experience enjoyable and efficient. $VND.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_13_19_51_06_d9b6d60578.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<VND>>(v1);
    }

    // decompiled from Move bytecode v6
}

