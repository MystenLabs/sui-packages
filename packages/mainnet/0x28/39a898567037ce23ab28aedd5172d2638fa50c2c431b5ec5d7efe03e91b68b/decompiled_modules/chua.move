module 0x2839a898567037ce23ab28aedd5172d2638fa50c2c431b5ec5d7efe03e91b68b::chua {
    struct CHUA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHUA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHUA>(arg0, 9, b"CHUA", b"ChuchaCoin", b"chucha is not just a token, but a mega token and just a valuable asset to lift the mood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9759f1fd-001b-4936-b662-350160993583.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHUA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHUA>>(v1);
    }

    // decompiled from Move bytecode v6
}

