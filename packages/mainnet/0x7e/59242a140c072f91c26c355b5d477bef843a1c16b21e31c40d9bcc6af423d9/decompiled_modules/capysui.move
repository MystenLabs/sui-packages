module 0x7e59242a140c072f91c26c355b5d477bef843a1c16b21e31c40d9bcc6af423d9::capysui {
    struct CAPYSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAPYSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAPYSUI>(arg0, 6, b"CAPYSUI", b"Capybara on Sui", b"Capybara is a meme AND a Telegram mini-game where you earn coins", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/6_E1q_Ow_Bu_400x400_cd340a794d.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAPYSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CAPYSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

