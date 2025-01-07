module 0x7c39c52e1010279d7caee7ce20184d97722f72a0b95b8aa0bbe4214ec0df52dd::ILUVTAINT {
    struct ILUVTAINT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ILUVTAINT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ILUVTAINT>(arg0, 6, b"ILUVTAINT", b"i love taint", b"aaa", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://images.pexels.com/photos/23656764/pexels-photo-23656764/free-photo-of-tourist-in-a-yellow-raincoat-taking-photos-in-the-rain.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ILUVTAINT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ILUVTAINT>>(v1);
    }

    // decompiled from Move bytecode v6
}

