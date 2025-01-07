module 0xb4b66abb80482514132addd7bc18af22c858859142b7a32cdd31c4c8f887ed01::kemjengun {
    struct KEMJENGUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: KEMJENGUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KEMJENGUN>(arg0, 6, b"KemJengUn", b"Kem Jeng Un", b"Mek Memes Gret Egen", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/U6_Yypb_AX_400x400_afe0548f21.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KEMJENGUN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KEMJENGUN>>(v1);
    }

    // decompiled from Move bytecode v6
}

