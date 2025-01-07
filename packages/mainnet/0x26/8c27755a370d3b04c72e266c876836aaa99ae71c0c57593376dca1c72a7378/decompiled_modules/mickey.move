module 0x268c27755a370d3b04c72e266c876836aaa99ae71c0c57593376dca1c72a7378::mickey {
    struct MICKEY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MICKEY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MICKEY>(arg0, 9, b"MICKEY", b"MICKEY", b"Offical", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://www.tbstat.com/wp/uploads/2023/10/sui_asset.jpeg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<MICKEY>(&mut v2, 1000000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MICKEY>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MICKEY>>(v1);
    }

    // decompiled from Move bytecode v6
}

