module 0xb73ca8f0f7142820975cfde9595b039e940aeb28eadba15b6944533a75f14432::uch {
    struct UCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: UCH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UCH>(arg0, 9, b"UCH", b"UNICHAIN", b"UNICHAIN is a revolutionary blockchain token that facilitates secure and efficient transactions across various decentralized applications. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/91111554-cced-4b1e-9e9c-b4cd18df1593.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UCH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<UCH>>(v1);
    }

    // decompiled from Move bytecode v6
}

