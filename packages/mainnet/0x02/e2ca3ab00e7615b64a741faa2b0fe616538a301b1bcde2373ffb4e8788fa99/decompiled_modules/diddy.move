module 0x2e2ca3ab00e7615b64a741faa2b0fe616538a301b1bcde2373ffb4e8788fa99::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 6, b"DIDDY", b"NO DIDDY", b"The croc drinking, take dat king ,party legend, Billionaire!! is entering the meme market. Puff DAddys about to be indicted. We will send this through the whole trial. Enjoy the ride............ No Diddy!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000036134_43f617c8ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DIDDY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
    }

    // decompiled from Move bytecode v6
}

