module 0x299297119869b5b71831c1dff735385c4c4b0c9dfa9c7c46097b908614da01ce::sguard {
    struct SGUARD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGUARD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGUARD>(arg0, 6, b"SGUARD", b"Sui Sguard", b"SGUARD - Cute guard dog on sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000008551_200ee05d87.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGUARD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGUARD>>(v1);
    }

    // decompiled from Move bytecode v6
}

