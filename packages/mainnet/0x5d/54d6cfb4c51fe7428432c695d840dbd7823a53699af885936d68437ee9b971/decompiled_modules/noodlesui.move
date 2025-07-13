module 0x5d54d6cfb4c51fe7428432c695d840dbd7823a53699af885936d68437ee9b971::noodlesui {
    struct NOODLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOODLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NOODLESUI>(arg0, 9, b"NDSUI", b"Noodlesui", b"A wiggly ramen noodle character with chopsticks for arms, slurping up Sui coins from a steaming bowl.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreieg3fhvupie4ekfwjsj3smuqfshdizmvhe7m6i42auc5xvy4nihgy")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<NOODLESUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOODLESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOODLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

