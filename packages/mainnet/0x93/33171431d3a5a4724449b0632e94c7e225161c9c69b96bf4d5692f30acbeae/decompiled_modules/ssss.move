module 0x9333171431d3a5a4724449b0632e94c7e225161c9c69b96bf4d5692f30acbeae::ssss {
    struct SSSS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SSSS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SSSS>(arg0, 6, b"SSSS", b"aaa starfish", b"Superb self-healing ability, better suited to survive in the digital currency space.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ae_e_f4a697d46d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SSSS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SSSS>>(v1);
    }

    // decompiled from Move bytecode v6
}

