module 0xeac37cc74d9a1a50472f39b6c81b3743f0c3daf797f7fac78c95e408c1b6414d::moya {
    struct MOYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOYA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOYA>(arg0, 6, b"MOYA", b"Moya on Sui", b"Cute Blockchain meme Moya Shiba ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/p8_O7_Ac_UM_400x400_38095ff547.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOYA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOYA>>(v1);
    }

    // decompiled from Move bytecode v6
}

