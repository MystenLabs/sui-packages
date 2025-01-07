module 0x569a2f28576a462dbb4d1e01931de7e33c864f7fab2eabc0ce9806b93bc8277d::sdori {
    struct SDORI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDORI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDORI>(arg0, 6, b"SDORI", b"DORI on SUI!", b"Lost and always exploring, DORI is here to dive deep into the Sui waters. Full of curiosity and a little mischief, this little fish has a big adventure ahead!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DORI_d92f0c130b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDORI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDORI>>(v1);
    }

    // decompiled from Move bytecode v6
}

