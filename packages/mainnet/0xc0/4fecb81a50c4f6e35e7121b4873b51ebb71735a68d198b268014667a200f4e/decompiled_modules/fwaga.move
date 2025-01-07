module 0xc04fecb81a50c4f6e35e7121b4873b51ebb71735a68d198b268014667a200f4e::fwaga {
    struct FWAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: FWAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FWAGA>(arg0, 4, b"FWAGA", b"FWAGA", b"FWAGA: Playful Politics, Unforgettable Characters!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://node1.irys.xyz/HyFJ6RxNywAfF6plBgaxEyRibhgbr-e1mRQtM6xHV_g")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<FWAGA>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FWAGA>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FWAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

