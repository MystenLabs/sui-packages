module 0x3adfeb3b422ae170c318715f31092e6e62b72b60141b30d8d05e87f1beb2644a::tatty {
    struct TATTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TATTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TATTY>(arg0, 6, b"TATTY", b"Gangsta duck TATTY", b"TATTY and his family of crypto gangsta ducks on SUI,looking for a new duck DoLaNd. Bones to pick,on a mission,to un matrix millions of people.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Qy_NVMUB_8_400x400_5f0be0c70d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TATTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TATTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

