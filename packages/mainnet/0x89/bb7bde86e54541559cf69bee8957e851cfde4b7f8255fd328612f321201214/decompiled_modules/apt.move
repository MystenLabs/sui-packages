module 0x89bb7bde86e54541559cf69bee8957e851cfde4b7f8255fd328612f321201214::apt {
    struct APT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APT>(arg0, 6, b"APT", b"Aptes", b"Hi, I am Mo Shaikh. I invented Move. Buy me", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Mohammad_Shaikh_aptos_token_sky_rocket_web_87e2fdd4df.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<APT>>(v1);
    }

    // decompiled from Move bytecode v6
}

