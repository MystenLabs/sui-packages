module 0x8dba637cca790c5f233045fa20729e6fb25bb9be4726e24616942103aeaecf97::supa {
    struct SUPA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUPA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUPA>(arg0, 6, b"SUPA", b"SupaPacificOnSui", b"$SUPA Meme token on pasific sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20241009_032829_cae4c3b846.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUPA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUPA>>(v1);
    }

    // decompiled from Move bytecode v6
}

