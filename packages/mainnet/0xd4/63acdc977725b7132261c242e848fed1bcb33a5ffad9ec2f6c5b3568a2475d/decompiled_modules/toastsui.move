module 0xd463acdc977725b7132261c242e848fed1bcb33a5ffad9ec2f6c5b3568a2475d::toastsui {
    struct TOASTSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOASTSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOASTSUI>(arg0, 9, b"TSTSUI", b"Toastsui", b"A slice of toast with butter forming the Sui logo, popping out of a toaster with arms spread wide.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://silver-urban-aardwolf-425.mypinata.cloud/ipfs/bafkreie46m6muafvsjwfnwi6ofhwkscwc2aumamey7y67x2rp47jimqigq")), arg1);
        let v2 = v0;
        0x2::coin::mint_and_transfer<TOASTSUI>(&mut v2, 1000000000000000000, @0x4c269af1a93409f39027fb2b8847924597d0e03d93ce33e7e0e94d098b0f0885, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOASTSUI>>(v2, @0x0);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOASTSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

