module 0xeac1859a9f883f51a8120cbcde4507968d9b5452955046980f18a3e38995e5f4::prl {
    struct PRL has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PRL>(arg0, 8, b"PRL", b"Pearl", b"GEM", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiIGYgxqNw1xapeHw4v5KOKi7URgC_dUOkkg&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<PRL>(&mut v2, 70000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRL>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRL>>(v1);
    }

    // decompiled from Move bytecode v6
}

