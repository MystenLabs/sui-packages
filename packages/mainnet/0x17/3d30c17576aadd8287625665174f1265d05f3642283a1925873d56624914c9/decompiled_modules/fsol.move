module 0x173d30c17576aadd8287625665174f1265d05f3642283a1925873d56624914c9::fsol {
    struct FSOL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FSOL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FSOL>(arg0, 6, b"FSOL", b"F#CK SOL", b"F#CK SOL is the ultimate rally cry for the fearless SOL chads who left a once thriving world now plagued by endless rugs and shady actors to embrace the boundless future of Sui. Our mission is simple: come together to say F#CK SOL, light up the path to fresh opportunities and celebrate the unstoppable spirit of Sui. Because when one chapter ends, another begins, and it's time to write a brighter, bolder story on Sui's shores together. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/u5618314944_Create_anime_image_of_girl_wearing_a_hat_that_say_db7bef05_10fe_47a5_ab53_ec1603fc54f7_0_1_04249b03ee.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FSOL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FSOL>>(v1);
    }

    // decompiled from Move bytecode v6
}

