module 0x13c1eda9a6009d237ae380301058faaee0c38cbf4f0ec1fd2be4a06eb999d68f::dogsurfing {
    struct DOGSURFING has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGSURFING, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DOGSURFING>(arg0, 9, b"DOGSURFING", b"DogSurfer", b"Look at the smile. Don't just take your dog to the beach, teach him surfing and make him happy.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/81ea692a-9f80-431e-a113-a4beaf0faf19.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGSURFING>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGSURFING>>(v1);
    }

    // decompiled from Move bytecode v6
}

