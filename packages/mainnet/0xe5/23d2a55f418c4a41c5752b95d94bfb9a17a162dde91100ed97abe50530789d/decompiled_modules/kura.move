module 0xe523d2a55f418c4a41c5752b95d94bfb9a17a162dde91100ed97abe50530789d::kura {
    struct KURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KURA>(arg0, 6, b"KURA", b"KURA INU ON SUI", b"KURA INU ON SUI KURA INU ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/65e6cb715c1e906f617a9439_shibcirc3_p_500_2304a75bda.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KURA>>(v1);
    }

    // decompiled from Move bytecode v6
}

