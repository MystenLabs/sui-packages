module 0xddd268032ccc7f675d7d025ad58c502cf7eed6dabee2529132ef13b1d32af519::badinu {
    struct BADINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BADINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BADINU>(arg0, 6, b"BADINU", b"BadInu Sui", b"www.badinu.com . To get on his good side, show Bad Inu that you are a primate and not a pussy cat. Then he will respect you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_10_15_092435_7000918cf4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BADINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BADINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

