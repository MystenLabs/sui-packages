module 0xb4ed1261094a1091715abdec01d362767b40ed0a869609fdf89d95eadc517f60::baffi {
    struct BAFFI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAFFI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAFFI>(arg0, 6, b"BAFFI", b"Baffi on Sui", x"48492049274d2042414646492054484520474952414646452046524f4d0a544845204c414e44204f462053554920414e4420490a43414e27542053544f502047524f57494e472e0a4920414d204845524520544f204c4f4f4b204f56455220594f555220414920434f494e530a4c554d2c20444f20594f552e20504c4159", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000053359_ad57efb869.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAFFI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAFFI>>(v1);
    }

    // decompiled from Move bytecode v6
}

