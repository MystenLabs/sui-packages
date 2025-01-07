module 0xfd2584b9bec80f913129641de86f371b935e81b8989db953c07c7312b486f4bc::atme {
    struct ATME has drop {
        dummy_field: bool,
    }

    fun init(arg0: ATME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ATME>(arg0, 9, b"Atme", b"A-Teameme", b"The legendary A-Team doggy's presents a powerfull meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<ATME>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ATME>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ATME>>(v1);
    }

    // decompiled from Move bytecode v6
}

