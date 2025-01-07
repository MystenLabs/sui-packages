module 0x90ac5bde534dd27cc72a157a704e9afc2f19ffd2fd744845fb724ae2220435c5::kingtrump {
    struct KINGTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: KINGTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KINGTRUMP>(arg0, 6, b"KINGTRUMP", b"KING TRUMP", x"546865206b696e67206f6620616d6572696361206973205452554d502c204d414b4520414d455249434120475245415420414741494e21210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/43_CA_1950_86_D5_4_DF_8_98_AF_4_C98_A0230_A59_d7eacaef19.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KINGTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KINGTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

