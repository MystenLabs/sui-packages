module 0x53b555369dc1ab9ca2d5342992681c559525cbd14bee0b24dbbde238afc0ec8d::kiofta {
    struct KIOFTA has drop {
        dummy_field: bool,
    }

    fun init(arg0: KIOFTA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KIOFTA>(arg0, 6, b"Kiofta", b"kioftahjfjsd", b"kjfsjlf dsjf ksdj fdsjfk sd fjskd fjsdk fmds fsd fds fjdslkfnkvndslk jvsd vds vsd vkjv ksdlvsd vsdkl vjkl  sjvkls dvkls vsdj vsdl vsdl vsdvjksd vj sdvkl dsvk lsdlv", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DALLA_E_2024_09_13_19_06_26_A_digital_artwork_of_the_Future_Ape_designed_for_use_on_a_website_The_character_is_a_blue_ape_from_the_future_with_a_sleek_and_modern_cyberpunk_aes_3cd4d3d7de.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KIOFTA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<KIOFTA>>(v1);
    }

    // decompiled from Move bytecode v6
}

