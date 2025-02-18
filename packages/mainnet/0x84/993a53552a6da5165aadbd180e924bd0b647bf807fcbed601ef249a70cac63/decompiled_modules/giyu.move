module 0x84993a53552a6da5165aadbd180e924bd0b647bf807fcbed601ef249a70cac63::giyu {
    struct GIYU has drop {
        dummy_field: bool,
    }

    fun init(arg0: GIYU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GIYU>(arg0, 9, b"GIYU", b"Giyu Tomioka", b"Ninja who can use a unique fighting style through breathing", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/QipUxJ0.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<GIYU>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GIYU>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GIYU>>(v1);
    }

    // decompiled from Move bytecode v6
}

