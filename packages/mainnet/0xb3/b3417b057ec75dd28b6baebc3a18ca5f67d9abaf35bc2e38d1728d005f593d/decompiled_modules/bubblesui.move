module 0xb3b3417b057ec75dd28b6baebc3a18ca5f67d9abaf35bc2e38d1728d005f593d::bubblesui {
    struct BUBBLESUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLESUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLESUI>(arg0, 9, b"BUBSUI", b"Bubblesui", b"A cheerful soap bubble creature with rainbow shimmer, floating with tiny Sui droplets inside its translucent body.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafybeif4leh44uyoi4iijutp7lzdqk65n4tawxphpeplfu75rvy23wjupq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<BUBBLESUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLESUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLESUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

