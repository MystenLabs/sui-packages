module 0xb18a2680b93d9db886588524a22db59c143a9c9bb088a639c0336a4e70ed8590::kombutt {
    struct KOMBUTT has drop {
        dummy_field: bool,
    }

    fun init(arg0: KOMBUTT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KOMBUTT>(arg0, 6, b"KOMBUTT", b"KOMBUTT ON SUI", b"LETS RIDE ALL MEMES", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ouq7o0_ed2e826099.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KOMBUTT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KOMBUTT>>(v1);
    }

    // decompiled from Move bytecode v6
}

