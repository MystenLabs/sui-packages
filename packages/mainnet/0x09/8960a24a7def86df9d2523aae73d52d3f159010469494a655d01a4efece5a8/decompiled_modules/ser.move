module 0x98960a24a7def86df9d2523aae73d52d3f159010469494a655d01a4efece5a8::ser {
    struct SER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SER>(arg0, 6, b"SER", b"SER on SUI", b"CALL ME $SER . The most sophisticated meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qml_Atid_400x400_e475e42eaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SER>>(v1);
    }

    // decompiled from Move bytecode v6
}

