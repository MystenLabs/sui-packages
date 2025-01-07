module 0x5e875b64b3252dab3e53bcb5d98264498909f6cb86d063072ee1780b013600d4::swk {
    struct SWK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SWK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SWK>(arg0, 6, b"SWK", b"Sui WuKong", b"SuiWuKong memecoin on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/8_EZ_Whp_HS_400x400_431db94629.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SWK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SWK>>(v1);
    }

    // decompiled from Move bytecode v6
}

