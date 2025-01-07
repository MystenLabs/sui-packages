module 0xae1bb1bb912cc55eb1d8463185c135b16c6b677f0804e11d1716dc553a84c0c1::manta {
    struct MANTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MANTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MANTA>(arg0, 9, b"MANTA", b"https://suimanta.xyz/", x"244d414e544120e2809320546865206669727374206d616e746120726179206f6e207468652053756920626c6f636b636861696e2c20676c6964696e67207468726f7567682044654669206f6365616e732e20506f776572206d6565747320706c617966756c6e6573732e205269646520746865207761766573207769746820244d414e544120f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1836816316671610881/9gUseZbo_400x400.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MANTA>(&mut v2, 222222222000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MANTA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MANTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

