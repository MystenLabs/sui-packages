module 0x1c77c4dff177864055a612c109022f8a374fc01638491d33b277568ab5593717::love {
    struct LOVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LOVE>(arg0, 8, b"LOVE", b"SuiLove", b"Gem in Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSpW22wVo4uONUopXNYCyC3TN1UF67Bnox1DQ&usqp=CAU")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<LOVE>(&mut v2, 60000000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOVE>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOVE>>(v1);
    }

    // decompiled from Move bytecode v6
}

