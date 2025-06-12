module 0x2ea8644a8d60118f8dc175e2237fc870dcfe510284b06955d5f225155d77790d::avab {
    struct AVAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: AVAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AVAB>(arg0, 9, b"AVAB", b"AvaBee", b"Meme AvaBee", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/acb679e6e673381bf8efed3f370d9ab0blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AVAB>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AVAB>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

