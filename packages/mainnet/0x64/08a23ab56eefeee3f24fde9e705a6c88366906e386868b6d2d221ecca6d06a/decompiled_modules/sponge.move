module 0x6408a23ab56eefeee3f24fde9e705a6c88366906e386868b6d2d221ecca6d06a::sponge {
    struct SPONGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONGE>(arg0, 6, b"SPONGE", b"SPONGE on Sui", b"$SPONGE, Just another good day on SuiNetwork ocean", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/s_Ruhe_Mq_400x400_3f0651f86a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPONGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

