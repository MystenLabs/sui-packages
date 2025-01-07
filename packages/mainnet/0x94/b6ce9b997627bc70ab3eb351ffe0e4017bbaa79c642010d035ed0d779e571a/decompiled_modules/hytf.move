module 0x94b6ce9b997627bc70ab3eb351ffe0e4017bbaa79c642010d035ed0d779e571a::hytf {
    struct HYTF has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYTF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYTF>(arg0, 6, b"hYTF", b"HUyt", b"THIS IS TEST", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241013225055_78e17dfd38.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYTF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYTF>>(v1);
    }

    // decompiled from Move bytecode v6
}

