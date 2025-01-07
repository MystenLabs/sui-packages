module 0xb71ac9c0c5db4bc3757f82ca0793e739a5ca208a29026a4aad498e2dab09ed2d::pus {
    struct PUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUS>(arg0, 6, b"PUS", b"Pepe unchained on sui", b"stealth launch of pepe unchained on movepump", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5764_0eaa00ea2f.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

