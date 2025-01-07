module 0xe312eea641e907d6bda4ec4f01f914fe1e9ef6f915b372ae0648202e8ffb65ce::riseofai {
    struct RISEOFAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISEOFAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<RISEOFAI>(arg0, 6, b"Riseofai", b"The rise of ai", b"The riseofai", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000906768_20d670a528.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISEOFAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISEOFAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

