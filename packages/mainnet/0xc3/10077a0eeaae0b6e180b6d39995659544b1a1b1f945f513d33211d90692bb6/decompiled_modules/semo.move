module 0xc310077a0eeaae0b6e180b6d39995659544b1a1b1f945f513d33211d90692bb6::semo {
    struct SEMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEMO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEMO>(arg0, 6, b"SEMO", b"SUINEMO", b"The baby fish suiming in the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/craiyon_182308_A_cheerful_cartoon_fish_with_bright_blue_and_green_colors_wearing_a_cute_apron_with_082e85e144.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEMO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SEMO>>(v1);
    }

    // decompiled from Move bytecode v6
}

