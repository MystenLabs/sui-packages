module 0xd6400d939badd41b093f9c890aad2935db2438dddcf703d43223a978b58198df::mtc {
    struct MTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MTC>(arg0, 9, b"MTC", b"Mala Cat", b"Mala the cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f0613a5b-589d-4772-9dc0-3eb07cc89de0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MTC>>(v1);
    }

    // decompiled from Move bytecode v6
}

