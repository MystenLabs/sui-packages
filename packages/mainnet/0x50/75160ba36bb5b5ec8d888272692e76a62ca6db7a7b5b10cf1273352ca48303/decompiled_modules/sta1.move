module 0x5075160ba36bb5b5ec8d888272692e76a62ca6db7a7b5b10cf1273352ca48303::sta1 {
    struct STA1 has drop {
        dummy_field: bool,
    }

    fun init(arg0: STA1, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STA1>(arg0, 6, b"STA1", b"STA001", b"001", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe(0x1::ascii::string(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT2Db_BxgWUfTecFfG2MmCR-umhk8FuIa7QYA&s"))), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<STA1>(&mut v2, 10000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STA1>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<STA1>>(v2);
    }

    // decompiled from Move bytecode v6
}

