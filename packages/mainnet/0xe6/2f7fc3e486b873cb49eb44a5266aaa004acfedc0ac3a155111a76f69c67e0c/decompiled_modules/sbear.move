module 0xe62f7fc3e486b873cb49eb44a5266aaa004acfedc0ac3a155111a76f69c67e0c::sbear {
    struct SBEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBEAR>(arg0, 6, b"SBEAR", b"sui bear", b"SBEAR hey", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0xb90b2a35c65dbc466b04240097ca756ad2005295_ff147cafca.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

