module 0x4daeb1238c3b5574a7f66277416ed4fa311bcbc8e156202e7b4a8123b24497b0::mbctoken {
    struct MBCTOKEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBCTOKEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBCTOKEN>(arg0, 6, b"MBCtoken", b"Mutant Boys Club", b"welcome to mutant boys club", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/mz_P0zylv_400x400_09dd1baa6d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBCTOKEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBCTOKEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

