module 0x88b3fdc15b3be557c896509055f1ec9967c2e779f70edc34a13a6d62aa62715c::diddy {
    struct DIDDY has drop {
        dummy_field: bool,
    }

    fun init(arg0: DIDDY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DIDDY>(arg0, 9, b"DIDDY", b"DIDDY", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://imagez.tmz.com/image/13/4by3/2024/09/25/13d90bba24a0477a9ebd5db3c784c013_md.jpg")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DIDDY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<DIDDY>>(0x2::coin::mint<DIDDY>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DIDDY>>(v2);
    }

    // decompiled from Move bytecode v6
}

