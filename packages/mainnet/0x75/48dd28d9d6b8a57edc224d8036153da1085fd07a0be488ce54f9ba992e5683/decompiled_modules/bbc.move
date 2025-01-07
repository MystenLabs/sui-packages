module 0x7548dd28d9d6b8a57edc224d8036153da1085fd07a0be488ce54f9ba992e5683::bbc {
    struct BBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBC>(arg0, 9, b"BBC", b"Big Black Cock", b"Fuck you bitch", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://cdn.thenewsroom.io/platform/posters/53a3898d-5e5c-11ee-80f4-c7e50ee5cade/c7cbf3b5a431-.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BBC>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

