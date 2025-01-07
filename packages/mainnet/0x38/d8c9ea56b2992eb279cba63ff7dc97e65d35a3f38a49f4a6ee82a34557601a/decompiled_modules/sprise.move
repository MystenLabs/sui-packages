module 0x38d8c9ea56b2992eb279cba63ff7dc97e65d35a3f38a49f4a6ee82a34557601a::sprise {
    struct SPRISE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPRISE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPRISE>(arg0, 6, b"SPRISE", b"SUIprise", b"Enjoy the SUIprise", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/LOGOSUIPRISE_8802170882.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPRISE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPRISE>>(v1);
    }

    // decompiled from Move bytecode v6
}

