module 0xfde6c00f1e8075bd6fed5315bf37f5b3946aadda8c5f90d97e3e2890a605ad85::lupita {
    struct LUPITA has drop {
        dummy_field: bool,
    }

    fun init(arg0: LUPITA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LUPITA>(arg0, 9, b"LUPITA", b"Lupita Nyong'o", b"Born: March 1, 1983, Mexico City, Mexico", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://a1.moviepassblack.com/w3/assets/LUPITA.pnghttps://a1.moviepassblack.com/w3/assets/LUPITA.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LUPITA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LUPITA>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LUPITA>>(v1);
    }

    // decompiled from Move bytecode v6
}

