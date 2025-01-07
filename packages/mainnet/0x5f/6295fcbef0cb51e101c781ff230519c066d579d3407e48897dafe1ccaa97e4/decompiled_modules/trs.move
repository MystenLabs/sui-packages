module 0x5f6295fcbef0cb51e101c781ff230519c066d579d3407e48897dafe1ccaa97e4::trs {
    struct TRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRS>(arg0, 9, b"TRS", b"TORSY", x"23544f5253592069732067656e65726174696e672061206c6f74206f66206578636974656d656e742e204974206c6f6f6b73206c696b65206120766572792070726f6d6973696e67206d656d652e0a0a5468652066616972206c61756e6368206973206c69766521f09f9a80f09f9a80f09f8e89f09f8e8920200a0a416e20657870657269656e636564207465616d20616e6420616e2061637469766520636f6d6d756e6974792061726520626568696e6420746869732070726f6a6563742e20497420646566696e6974656c7920686173206c6f6e672d7465726d20706f74656e7469616c2e2020", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/229fe96e-c27c-4584-9e65-e34b31dc1d72.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRS>>(v1);
    }

    // decompiled from Move bytecode v6
}

