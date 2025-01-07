module 0xff744288a734a99bd83615198b3d96caec3c57b5bbc38539b35ac83c82270104::sui_tate {
    struct SUI_TATE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUI_TATE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUI_TATE>(arg0, 3, b"Sui Tate", b"Sui Tate", b"A sexy man", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://upload.wikimedia.org/wikipedia/commons/thumb/f/f1/Andrew_Tate_on_%27Anything_Goes_With_James_English%27_in_2021.jpg/640px-Andrew_Tate_on_%27Anything_Goes_With_James_English%27_in_2021.jpg")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<SUI_TATE>(&mut v2, 10000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUI_TATE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUI_TATE>>(v1);
    }

    // decompiled from Move bytecode v6
}

