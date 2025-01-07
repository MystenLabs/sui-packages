module 0x30fe2be9b585076f2d10d0349f1f7f333a08f4d79e2b9eb8babed671b8770d48::suiguy {
    struct SUIGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGUY>(arg0, 6, b"Suiguy", b"Chill Sui Guy", b"Just a chill Sui guy chilling on all season on Sui!!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2295_1a254935cd.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGUY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGUY>>(v1);
    }

    // decompiled from Move bytecode v6
}

