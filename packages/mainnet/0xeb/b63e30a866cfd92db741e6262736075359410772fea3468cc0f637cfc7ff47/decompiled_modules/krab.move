module 0xebb63e30a866cfd92db741e6262736075359410772fea3468cc0f637cfc7ff47::krab {
    struct KRAB has drop {
        dummy_field: bool,
    }

    fun init(arg0: KRAB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KRAB>(arg0, 9, b"KRAB", b"Mr.Krab", b"krab meme on sui chain", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://pbs.twimg.com/profile_images/1844450738187202560/G5J9VHWM.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KRAB>(&mut v2, 15000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KRAB>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KRAB>>(v1);
    }

    // decompiled from Move bytecode v6
}

