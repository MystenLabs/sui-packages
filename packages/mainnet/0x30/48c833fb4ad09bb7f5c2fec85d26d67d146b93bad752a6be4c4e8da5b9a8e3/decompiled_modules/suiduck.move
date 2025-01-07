module 0x3048c833fb4ad09bb7f5c2fec85d26d67d146b93bad752a6be4c4e8da5b9a8e3::suiduck {
    struct SUIDUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDUCK>(arg0, 6, b"SUIDUCK", b"SUIDUCK", b"", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkeSqFaod7jFjHL5ZJXWJ9bV9QbqATMt9qWA&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIDUCK>(&mut v2, 6666666667000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDUCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDUCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

