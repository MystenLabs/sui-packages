module 0x62b5effa4f38d98909e13b6eefd7f7469d9fb037039f5b78260be3786dc5ba06::sap {
    struct SAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAP>(arg0, 9, b"SAP", b"Chibby4luv", b"The best and fast growing meme coin to change the game ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9c7e178a-d23d-41b0-9be6-41b9a7e8f173.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SAP>>(v1);
    }

    // decompiled from Move bytecode v6
}

