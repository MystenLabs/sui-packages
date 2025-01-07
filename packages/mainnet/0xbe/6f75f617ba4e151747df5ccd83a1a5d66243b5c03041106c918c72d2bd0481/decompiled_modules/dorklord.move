module 0xbe6f75f617ba4e151747df5ccd83a1a5d66243b5c03041106c918c72d2bd0481::dorklord {
    struct DORKLORD has drop {
        dummy_field: bool,
    }

    fun init(arg0: DORKLORD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DORKLORD>(arg0, 6, b"DorkLord", b"Dork lord sui", b"Inspired by the hilarious and iconic character created by Matt Furie, Dorklord is here to conquer the SUI blockchain and bring balance to the meme universe. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3852_b3f58742cf.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DORKLORD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DORKLORD>>(v1);
    }

    // decompiled from Move bytecode v6
}

