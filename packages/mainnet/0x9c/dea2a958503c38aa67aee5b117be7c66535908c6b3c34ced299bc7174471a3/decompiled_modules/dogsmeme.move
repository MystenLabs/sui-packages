module 0x9cdea2a958503c38aa67aee5b117be7c66535908c6b3c34ced299bc7174471a3::dogsmeme {
    struct DOGSMEME has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSMEME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSMEME>(arg0, 6, b"DOGSMEME", b"Dogs", b"Doges meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://akasui-statics.sgp1.cdn.digitaloceanspaces.com/images/72c3ed17-3520-45a6-b87a-89cb766b1e06.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSMEME>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSMEME>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

