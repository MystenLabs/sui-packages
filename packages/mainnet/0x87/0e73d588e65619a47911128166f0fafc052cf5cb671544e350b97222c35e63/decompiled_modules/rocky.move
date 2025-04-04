module 0x870e73d588e65619a47911128166f0fafc052cf5cb671544e350b97222c35e63::rocky {
    struct ROCKY has drop {
        dummy_field: bool,
    }

    fun init(arg0: ROCKY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ROCKY>(arg0, 9, b"ROCKY", b"Rockstar", b"A meme with rockstar", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/3a5bbeaa96d7d7358cd90cc164f5e075blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ROCKY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ROCKY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

