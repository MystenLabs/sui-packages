module 0x2722c5202d144948bc2aa3ddda85f4131806c442b9cd091638c092fb5cad8f2f::hyuse {
    struct HYUSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: HYUSE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HYUSE>(arg0, 9, b"HYUSE", b"Hyuse", b"Unique magic skills with horns", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/WTrhgD1.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<HYUSE>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HYUSE>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HYUSE>>(v1);
    }

    // decompiled from Move bytecode v6
}

