module 0x34d474fd2fa2034c125f29c83d880939d555d5a524d96d5ddc71b8852d3823a5::ssdog {
    struct SSDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSDOG>(arg0, 6, b"SSDOG", b"Social Security Dog", b"ssdog(Social Security Dog),the meme coin that's here to safeguard your crypto future! With a loyal community behind it, every transaction is a wag of support. Join us to unleash fun, rewards, and a whole new way to secure your digital assets. Get ready to bark up the right tree in the world of crypto", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/a_ae_a_c_20241017231455_50cc88c52f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

