module 0x7e598584826d7b5dce6089477fadec80a6e67001fc536618fa65101440c310e4::fuckyou {
    struct FUCKYOU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FUCKYOU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FUCKYOU>(arg0, 6, b"FUCKYOU", b"Ceelo Green coin", b"I SEE YOU DRIVIN' DOWNTOWN WITH THE GIRL I LOVE, AND IM LIKE...", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreifhkpcvmadxzr2fknn7wzt3rejklkwv37eljmuzldauilt5amzbmu")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FUCKYOU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<FUCKYOU>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

