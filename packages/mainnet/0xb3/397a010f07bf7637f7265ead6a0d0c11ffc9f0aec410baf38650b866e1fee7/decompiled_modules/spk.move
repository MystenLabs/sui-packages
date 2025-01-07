module 0xb3397a010f07bf7637f7265ead6a0d0c11ffc9f0aec410baf38650b866e1fee7::spk {
    struct SPK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPK>(arg0, 9, b"SPK", b"Spink", b"0xc1ba2a96a95aa621a356064617888be7863bb8c2f6db560ded8814edcc9d1423", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/25a8c541-b4bc-4bd5-8c06-6d805a2b3273.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPK>>(v1);
    }

    // decompiled from Move bytecode v6
}

