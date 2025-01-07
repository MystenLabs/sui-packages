module 0xefd7307eece17e3ff35f99b613e8e34dc1381f6d57d74c5a882058df0a7aa6f5::suiflock {
    struct SUIFLOCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIFLOCK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIFLOCK>(arg0, 9, b"SuiFlock", b"FLOCKERZ LP", b"https://t.me/suiflockerz", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUIFLOCK>(&mut v2, 130000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIFLOCK>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIFLOCK>>(v1);
    }

    // decompiled from Move bytecode v6
}

