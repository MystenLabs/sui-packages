module 0xd8cbff76db7f3640afb9680ef9c06c757b634862a3c124b7a2edf75c32883f45::ploop {
    struct PLOOP has drop {
        dummy_field: bool,
    }

    fun init(arg0: PLOOP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PLOOP>(arg0, 6, b"Ploop", b"PloopSui", b"Small steps, big memes. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_16_060049471_8f43f202ac.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PLOOP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PLOOP>>(v1);
    }

    // decompiled from Move bytecode v6
}

