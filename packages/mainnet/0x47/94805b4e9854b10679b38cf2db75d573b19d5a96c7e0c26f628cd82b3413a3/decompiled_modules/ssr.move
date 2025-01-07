module 0x4794805b4e9854b10679b38cf2db75d573b19d5a96c7e0c26f628cd82b3413a3::ssr {
    struct SSR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSR>(arg0, 6, b"SSR", b"Sui Silk Road", b"History can repeat itself again and again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Road_131bba32a4.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSR>>(v1);
    }

    // decompiled from Move bytecode v6
}

