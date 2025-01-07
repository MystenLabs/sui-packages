module 0x73879cf9e9b1cf9a7ae156c24750e95bbb58a8346d4eedf04f27defc911cf42f::sbc {
    struct SBC has drop {
        dummy_field: bool,
    }

    fun init(arg0: SBC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SBC>(arg0, 4, b"SBC", b"SuiBaseCamo", b"...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTYcle6_mMUsK71MK-g8XKB-12wGeLCOfjZYTNgD9bFIRdYdQHLHvuOxsPfONZrz0g0638&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SBC>(&mut v2, 100000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SBC>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SBC>>(v1);
    }

    // decompiled from Move bytecode v6
}

