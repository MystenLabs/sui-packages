module 0x2363e69dfafde4752766984535b40776fb327ed583255f37b0e6cfd15b46917a::ps {
    struct PS has drop {
        dummy_field: bool,
    }

    fun init(arg0: PS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PS>(arg0, 6, b"PS", b"PESUI", x"546f2062652066696e616e6369616c6c7920667265652e0a57652061726520776f726b696e67206f6e20746865206e6577207765627369746520616e6420616c6c2074686520746f6f6c732e0a446f6e277420626c616d6520796f757273656c6620696620796f7520646f6e2774206765742061207368617265206f662069742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Albedo_Base_XL_pepe_sui_meme_coin_blue_funy_and_s_logo_2_80e37b17a3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PS>>(v1);
    }

    // decompiled from Move bytecode v6
}

