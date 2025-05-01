module 0x4f6d9e51bfe4339150a20f7804fc7c66af929fd985a1a6ec0219ae87007634a::lwh {
    struct LWH has drop {
        dummy_field: bool,
    }

    fun init(arg0: LWH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LWH>(arg0, 6, b"LWH", b"LofiWifHat", b"Lofi vibes, cool hat, big energy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/lofi_perfil_c38f2a45c1.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LWH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LWH>>(v1);
    }

    // decompiled from Move bytecode v6
}

