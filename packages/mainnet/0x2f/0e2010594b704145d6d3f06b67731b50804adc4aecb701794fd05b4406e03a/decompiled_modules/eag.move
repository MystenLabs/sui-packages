module 0x2f0e2010594b704145d6d3f06b67731b50804adc4aecb701794fd05b4406e03a::eag {
    struct EAG has drop {
        dummy_field: bool,
    }

    fun init(arg0: EAG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EAG>(arg0, 9, b"EAG", b"EAGLEBYTE ", b"Eaglebyte is a community-driven meme coin that navigates the depths of blockchain innovation and financial inclusivity.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/49c40e8f-3225-486e-ace1-7c037e51a8e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EAG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EAG>>(v1);
    }

    // decompiled from Move bytecode v6
}

