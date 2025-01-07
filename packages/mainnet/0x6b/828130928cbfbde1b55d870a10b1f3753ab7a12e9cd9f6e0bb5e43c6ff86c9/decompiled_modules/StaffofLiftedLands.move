module 0x6b828130928cbfbde1b55d870a10b1f3753ab7a12e9cd9f6e0bb5e43c6ff86c9::StaffofLiftedLands {
    struct STAFFOFLIFTEDLANDS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STAFFOFLIFTEDLANDS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STAFFOFLIFTEDLANDS>(arg0, 0, b"COS", b"Staff of Lifted Lands", b"The Aurahma have crafted a mystical Sui staff to celebrate the Project Eluune x Mysten Labs partnership!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://aurahma-canvas-test-bucket.s3.eu-west-3.amazonaws.com/cosmetic/Staff_of_Lifted_Lands.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<STAFFOFLIFTEDLANDS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STAFFOFLIFTEDLANDS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

