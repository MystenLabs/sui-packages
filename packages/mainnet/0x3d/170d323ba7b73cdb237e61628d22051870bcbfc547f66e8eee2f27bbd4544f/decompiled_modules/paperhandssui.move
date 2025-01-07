module 0x3d170d323ba7b73cdb237e61628d22051870bcbfc547f66e8eee2f27bbd4544f::paperhandssui {
    struct PAPERHANDSSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PAPERHANDSSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PAPERHANDSSUI>(arg0, 2, b"PaperHandsSui", b"PaperHandsSui", b"PaperHandsSui is an innovative meme token that combines humor and creativity in the world of cryptocurrency. Inspired by the term \"paper hands,\" which refers to traders who sell their assets quickly, this token offers a relaxed and entertaining approach to digital investment.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PAPERHANDSSUI>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PAPERHANDSSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PAPERHANDSSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

