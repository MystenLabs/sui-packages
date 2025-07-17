module 0x9ee5d0e49f29d645d4f4526275ef31ed604529c20880bac27ba30165203b1380::aura {
    struct AURA has drop {
        dummy_field: bool,
    }

    fun init(arg0: AURA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AURA>(arg0, 6, b"AURA", b"Aura Lofi", b"Do you feel this energy? This is called AURA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafybeifsna45dvb3eiaze2u6fvegul6zu2psluuzwi4wnkpijpgrqf2gi4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AURA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AURA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

