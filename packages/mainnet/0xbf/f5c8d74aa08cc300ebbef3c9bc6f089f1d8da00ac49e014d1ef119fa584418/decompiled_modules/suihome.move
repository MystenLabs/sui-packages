module 0xbff5c8d74aa08cc300ebbef3c9bc6f089f1d8da00ac49e014d1ef119fa584418::suihome {
    struct SUIHOME has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIHOME, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIHOME>(arg0, 6, b"SuiHome", b"SuiHomeAlabama", x"537765657420686f6d6520416c6162616d61210a57686572652074686520736b6965732061726520736f20626c756521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_5568_87dbe444a3.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIHOME>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIHOME>>(v1);
    }

    // decompiled from Move bytecode v6
}

