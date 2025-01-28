module 0xffe2dd38fc3a114d6ff42b62245fb329b1cc2b2c23f700838d6b86240ed50530::tet {
    struct TET has drop {
        dummy_field: bool,
    }

    fun init(arg0: TET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TET>(arg0, 6, b"TET", b"TETTT", b"TETTTT", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://public-cdn.daossui.io/assets/tokens/0c3f4220-dd4c-11ef-a403-694c756e712a")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TET>>(v1);
        0x2::coin::mint_and_transfer<TET>(&mut v2, 1100000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TET>>(v2, @0x0);
    }

    // decompiled from Move bytecode v6
}

