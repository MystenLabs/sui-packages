module 0xb9b2de95b9fddaafb656111f4400c88ab1316afc22fc5c13dce08f8ed02755ee::nac {
    struct NAC has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAC>(arg0, 6, b"NAC", b"NOT A CHEEMS", b"meme dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/smiling_dog_meme_beltschazar_transparent_161ff3a41a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAC>>(v1);
    }

    // decompiled from Move bytecode v6
}

