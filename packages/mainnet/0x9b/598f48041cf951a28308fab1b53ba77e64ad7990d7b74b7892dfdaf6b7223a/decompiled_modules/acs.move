module 0x9b598f48041cf951a28308fab1b53ba77e64ad7990d7b74b7892dfdaf6b7223a::acs {
    struct ACS has drop {
        dummy_field: bool,
    }

    fun init(arg0: ACS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ACS>(arg0, 6, b"ACS", b"aaaCatSui", b"Can't stop won't stop (thinking about Sui) ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/AAAA_bd14a86dc3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ACS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ACS>>(v1);
    }

    // decompiled from Move bytecode v6
}

