module 0xedeeb3894b6ff7068bfd20858b5908488ae92643e0ecb683fd4f54a92e5613f4::bunny {
    struct BUNNY has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUNNY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUNNY>(arg0, 9, b"BUNNY", b"Sui Bunnys", b"Bunnys Meme on SUI  https://bunnys.meme  https://x.com/suibunnys  https://t.me/suibunnys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"Bunnys Meme on SUI  https://bunnys.meme  https://x.com/suibunnys  https://t.me/sui_bunnys")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUNNY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUNNY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUNNY>>(v1);
    }

    // decompiled from Move bytecode v6
}

