module 0xcd851eef47242f09f7c30e54d51ee46ceb2aabc68ae89f5c9080c056db134850::tgm {
    struct TGM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TGM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TGM>(arg0, 9, b"TGM", b"THANGAM", b"THANGAM is a heartfelt initiative dedicated to promoting global healing through love, compassion, and community engagement. Our mission is to inspire individuals and communities to come together, fostering a culture of k", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/59856299-3db6-438b-9b3f-4134d9f70452.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TGM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TGM>>(v1);
    }

    // decompiled from Move bytecode v6
}

