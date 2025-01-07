module 0xa388b8a4c361216a6d2b96f99358a615fa0bc9777d13347fe0a8a712ca94dafa::ddeer {
    struct DDEER has drop {
        dummy_field: bool,
    }

    fun init(arg0: DDEER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DDEER>(arg0, 6, b"DDEER", b"DAPPER DEER", b"Graceful, stylish, and always aiming for the top. Dapper Deer is the meme of elegance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/image_2024_12_21_041329208_433c92028c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DDEER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DDEER>>(v1);
    }

    // decompiled from Move bytecode v6
}

