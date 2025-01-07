module 0xc7551c64a670a10fac753a0cc3d2d3dd20a52745f6591476553896ce2d0ab23a::suiboy {
    struct SUIBOY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBOY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBOY>(arg0, 6, b"SUIBOY", b"Suinny Boy", b"Just an average sunny boy on sui.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Untitled_compressed_5973bebf23.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBOY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIBOY>>(v1);
    }

    // decompiled from Move bytecode v6
}

