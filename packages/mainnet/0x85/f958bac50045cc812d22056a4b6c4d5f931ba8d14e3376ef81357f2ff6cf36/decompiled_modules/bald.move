module 0x85f958bac50045cc812d22056a4b6c4d5f931ba8d14e3376ef81357f2ff6cf36::bald {
    struct BALD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BALD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BALD>(arg0, 6, b"Bald", b"Bald on sui", b"$Bald on the SUI network so that there will be a revolution of other memeA bald man who will bring a new shine to the best network in the world.let's raise the peaks together.DEX we are coming with an army of bald guys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_1818_7708a324fb.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BALD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BALD>>(v1);
    }

    // decompiled from Move bytecode v6
}

