module 0xa5fa1ae3b9f3870d897a85e2af910f3796e7806ed7c943e13e15f37ed2e8bfc0::kate {
    struct KATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: KATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KATE>(arg0, 9, b"KATE", b"Mate Kiddleton", b"A coin as legit as Kate Middleton's disappearance.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://people.com/thmb/YV_0LtUpBB9bIjVCg_USelcwKyw=/1500x0/filters:no_upscale():max_bytes(150000):strip_icc():focal(824x577:826x579):format(webp)/Kate-Middleton-Mothers-Day-03102401-46ba4811a39a402a9bfc824f4b60a4e2.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<KATE>(&mut v2, 10000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KATE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

