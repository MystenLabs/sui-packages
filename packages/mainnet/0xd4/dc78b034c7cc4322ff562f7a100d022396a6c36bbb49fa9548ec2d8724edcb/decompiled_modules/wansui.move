module 0xd4dc78b034c7cc4322ff562f7a100d022396a6c36bbb49fa9548ec2d8724edcb::wansui {
    struct WANSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WANSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WANSUI>(arg0, 6, b"WANSUI", b"Wansui - Wanna on Sui", b"Just the beginning of the legend on Sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/4s_82i_JI_400x400_1959bc7ad6.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WANSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WANSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

