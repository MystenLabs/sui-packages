module 0xada8b053b745fe050d3502b5cbd527ebb94a47780565e45617f16668162a045a::pass {
    struct PASS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PASS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PASS>(arg0, 6, b"PASS", b"PEPE ASS", b"Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/D_D_D_D_f9e6cd4276.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PASS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PASS>>(v1);
    }

    // decompiled from Move bytecode v6
}

