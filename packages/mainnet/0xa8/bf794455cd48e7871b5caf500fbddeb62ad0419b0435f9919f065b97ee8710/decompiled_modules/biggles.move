module 0xa8bf794455cd48e7871b5caf500fbddeb62ad0419b0435f9919f065b97ee8710::biggles {
    struct BIGGLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: BIGGLES, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BIGGLES>(arg0, 9, b"BIGGLES", b"Mr. Bigglesworth", b"Mr. Bigglesworth is Dr. Evil's hairless pet cat in the Austin Powers franchise. He was originally a long-haired white Persian cat like the one constantly held by Ernst Stavro Blofeld of the James Bond franchise.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://dd.dexscreener.com/ds-data/tokens/base/0xd19b9f5db9d56d0660f20dc7174b54abef3ef413.png?size=xl&key=1e63b6")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BIGGLES>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BIGGLES>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BIGGLES>>(v1);
    }

    // decompiled from Move bytecode v6
}

