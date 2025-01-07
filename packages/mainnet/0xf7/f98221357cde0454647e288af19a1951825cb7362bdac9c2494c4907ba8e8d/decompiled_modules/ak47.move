module 0xf7f98221357cde0454647e288af19a1951825cb7362bdac9c2494c4907ba8e8d::ak47 {
    struct AK47 has drop {
        dummy_field: bool,
    }

    fun init(arg0: AK47, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AK47>(arg0, 6, b"AK47", b"AK47 (A KAT)", b"TERRORISM KAT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Gaqnj_Vb_S_Ls2u_A_6aa301b011.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AK47>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AK47>>(v1);
    }

    // decompiled from Move bytecode v6
}

