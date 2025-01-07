module 0x4681a22ff01169826cf7503194f2dc210a41787668270ef26ea1ffb106dbe046::cat {
    struct CAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT>(arg0, 9, b"CAT", b"blackcat", x"0a54686520737472616e6765206e6174757265206f6620636174732c20666561747572696e6720617474726163746976652066656c696e652d7468656d6564206272616e6473", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6e37152b-3494-4969-bb8b-ab2a0fc12ecd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

