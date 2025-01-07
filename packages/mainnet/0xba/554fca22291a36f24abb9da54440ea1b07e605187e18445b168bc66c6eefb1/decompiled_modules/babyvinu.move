module 0xba554fca22291a36f24abb9da54440ea1b07e605187e18445b168bc66c6eefb1::babyvinu {
    struct BABYVINU has drop {
        dummy_field: bool,
    }

    fun init(arg0: BABYVINU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BABYVINU>(arg0, 6, b"BABYVINU", b"Baby Vita inu", x"54686520576f726c642773204669727374204c696768742d53706565640a446f6720436f696e2077697468205a65726f204665657320616e640a536d61727420436f6e7472616374732e2052574120414e44204d4f52450a546865206f6e6c79206d656d65636f696e2077697468207265616c20776f726c64207574696c6974792e205a65726f20666565732c20696e7374616e7420736574746c656d656e7420616e6420746865206869676865737420656e6572677920656666696369656e6379206f75742074686572652e2057686174206d6f726520636f756c6420796f752061736b20666f723f204a6f696e206f757220666173742067726f77696e6720636f6d6d756e69747921", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_11_29_18_11_20_A_baby_version_of_a_Shiba_Inu_inspired_character_similar_to_the_Vita_Inu_logo_The_3_D_rendered_cartoon_style_dog_has_vibrant_blue_and_white_fur_a_joy_9986684c9f.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BABYVINU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BABYVINU>>(v1);
    }

    // decompiled from Move bytecode v6
}

