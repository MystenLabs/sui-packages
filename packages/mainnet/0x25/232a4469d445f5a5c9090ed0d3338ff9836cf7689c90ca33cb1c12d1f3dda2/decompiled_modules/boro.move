module 0x25232a4469d445f5a5c9090ed0d3338ff9836cf7689c90ca33cb1c12d1f3dda2::boro {
    struct BORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BORO>(arg0, 6, b"BORO", b"BOOK OF RETARDIO", b"Thats all what you need to be in $BORO cult ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_17_07_58_14_62fe224756.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

