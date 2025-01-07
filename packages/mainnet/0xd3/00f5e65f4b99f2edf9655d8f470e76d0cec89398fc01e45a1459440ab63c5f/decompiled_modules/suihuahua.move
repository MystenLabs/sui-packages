module 0xd300f5e65f4b99f2edf9655d8f470e76d0cec89398fc01e45a1459440ab63c5f::suihuahua {
    struct SUIHUAHUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHUAHUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHUAHUA>(arg0, 6, b"SUIHUAHUA", b"Suihuahua", b"SUIHUAHUA, the delightful gem in the meme coin universe on the SUI blockchain. SUIHUAHUA adds a cheerful spin with its chihuahua-inspired flair. Discover the whimsical world of SUIHUAHUA, where crypto dances with humor, and embark on the journey to the next big meme coin phenomenon on SUI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Logo_Move_Pump_260be4d540.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHUAHUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHUAHUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

