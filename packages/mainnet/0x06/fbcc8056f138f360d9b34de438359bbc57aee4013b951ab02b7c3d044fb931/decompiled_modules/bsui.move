module 0x6fbcc8056f138f360d9b34de438359bbc57aee4013b951ab02b7c3d044fb931::bsui {
    struct BSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: BSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BSUI>(arg0, 6, b"BSUI", b"Bionic Sui", b"Bionic Sui is not just an ordinary characterits a digital guardian equipped with bionic power, born from the hidden technology buried deep within the SUI bloc", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Dy2_DT_Pcy_400x400_db7105eac7.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BSUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BSUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

