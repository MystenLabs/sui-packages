module 0xd9bbb87de84f4a54f16a49c5cf354e3740df001ef8d230d9171f31a53d768ab3::nagi {
    struct NAGI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NAGI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NAGI>(arg0, 9, b"NAGI", b"Seishiro Nagi", b"Nagi is a very lazy and unmotivated person with an outstanding aptitude for football. He's unnaturally talented, with amazing reflexes, good speed, and jumping skills. But he has no interest in going pro or even playing at all at first.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://i.imgur.com/qyd0UZG_d.png")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NAGI>(&mut v2, 0, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NAGI>>(v2, @0xebc707141970574ece90991112fe9a682d03b1596db6ca8981a29f385cbf76d6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NAGI>>(v1);
    }

    // decompiled from Move bytecode v6
}

