module 0xe4513945b5ed3bb6c0d7dbfe18ec874aa4301b4c4414c533e83bef3ac8d3ab2a::baked {
    struct BAKED has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAKED, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BAKED>(arg0, 6, b"BAKED", b"BAKEDTOKEN", b"@bakedtoken", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Fo_Jvz9lq_400x400_4462adabf7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAKED>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAKED>>(v1);
    }

    // decompiled from Move bytecode v6
}

