module 0xaac909ba61655994c0c005a8007428ebeac18a3bcb2ba7e20fbae7736c491e49::sipe {
    struct SIPE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SIPE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SIPE>(arg0, 6, b"Sipe", b"suipepe", b"Pepe and his family came here to have fun, and they prepared 500 family photos to airdrop to all holders", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/S_159457313_0f9ced169a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SIPE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SIPE>>(v1);
    }

    // decompiled from Move bytecode v6
}

