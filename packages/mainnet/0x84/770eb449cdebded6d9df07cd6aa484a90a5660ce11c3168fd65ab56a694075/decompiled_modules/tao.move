module 0x84770eb449cdebded6d9df07cd6aa484a90a5660ce11c3168fd65ab56a694075::tao {
    struct TAO has drop {
        dummy_field: bool,
    }

    fun init(arg0: TAO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TAO>(arg0, 9, b"Tao", b"Tariffs are our everything", b"The meme is dedicated to stupid politicians and their games that lead us to an Interesting Future", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/db64d00a565e75d23e0bf38bac07fdc9blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TAO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TAO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

