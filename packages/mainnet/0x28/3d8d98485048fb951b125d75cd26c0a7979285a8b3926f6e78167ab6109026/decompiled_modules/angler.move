module 0x283d8d98485048fb951b125d75cd26c0a7979285a8b3926f6e78167ab6109026::angler {
    struct ANGLER has drop {
        dummy_field: bool,
    }

    fun init(arg0: ANGLER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ANGLER>(arg0, 6, b"ANGLER", b"SUI ANGLER", b"Deepest fish on all SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/angler_ad5c65c69f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ANGLER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ANGLER>>(v1);
    }

    // decompiled from Move bytecode v6
}

