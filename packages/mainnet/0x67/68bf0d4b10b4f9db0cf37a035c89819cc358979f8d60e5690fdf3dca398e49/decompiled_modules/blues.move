module 0x6768bf0d4b10b4f9db0cf37a035c89819cc358979f8d60e5690fdf3dca398e49::blues {
    struct BLUES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUES>(arg0, 6, b"BLUES", b"Blue Sui Move", b"First SUI integration with Blue Move, collab between chain and platform.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Sk_Agauhd_400x400_ba564cc169.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUES>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUES>>(v1);
    }

    // decompiled from Move bytecode v6
}

