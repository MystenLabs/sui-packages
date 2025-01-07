module 0x46fd788bfbcd6c2e48f5e2751152635c4ce6560b27717802387813778eed332a::dook {
    struct DOOK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOOK>(arg0, 6, b"DOOK", b"Shoobadookie Sui", b"Shoobadookie promises nothing but will become part of everything.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ss_300x300_e19f210e50.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOOK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOOK>>(v1);
    }

    // decompiled from Move bytecode v6
}

