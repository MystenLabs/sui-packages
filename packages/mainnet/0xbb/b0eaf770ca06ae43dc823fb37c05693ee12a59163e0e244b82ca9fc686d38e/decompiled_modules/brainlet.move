module 0xbbb0eaf770ca06ae43dc823fb37c05693ee12a59163e0e244b82ca9fc686d38e::brainlet {
    struct BRAINLET has drop {
        dummy_field: bool,
    }

    fun init(arg0: BRAINLET, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BRAINLET>(arg0, 6, b"BRAINLET", b"Brainlet", x"427261696e6c65743a2054686520636f696e20736f2064756d622c206974206d69676874206a7573742062652067656e6975732e0a0a496e74726f647563696e6720427261696e6c65742c20746865206d656d6520636f696e20666f722074686f73652077686f207468696e6b20322b3220657175616c7320666973682e202044657369676e656420666f722074686520636f6d6d756e697479207468617420656d627261636573206265696e6720636c75656c6573732062757420736f6d65686f7720616c77617973206c616e6473206f6e20746f70", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_08_07_01_55_07_2193945eb0.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BRAINLET>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BRAINLET>>(v1);
    }

    // decompiled from Move bytecode v6
}

