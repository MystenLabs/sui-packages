module 0x5bd9a12659037fda92f45e527d4c012b80ccd73f8df855117c587769eb34837::chan {
    struct CHAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAN>(arg0, 9, b"CHAN", b"Jackie Chan", b"Coin representing the actor jackie chan", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.hollywoodreporter.com/wp-content/uploads/2012/07/chan_a.jpg?w=2000&h=1126&crop=1")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<CHAN>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAN>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

