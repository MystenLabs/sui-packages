module 0xd9c18f1d6fff29e35d1a750ebf26c261796afa15358903384f7f95be4945705d::narnia {
    struct NARNIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NARNIA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NARNIA>(arg0, 9, b"NARNIA", b"The Chronicles of Narnia: The Lion, the Witch and the Wardrobe", b"Road to Narnia", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/torX0sM.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NARNIA>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NARNIA>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NARNIA>>(v1);
    }

    // decompiled from Move bytecode v6
}

