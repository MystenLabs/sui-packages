module 0x9afbdd236f5ac14525b12b6e76503717abe3de1be587126429635702005dc315::bmw {
    struct BMW has drop {
        dummy_field: bool,
    }

    fun init(arg0: BMW, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BMW>(arg0, 9, b"BMW", b"Bayerische", b"It is the full name of the big German super company that the whole world knows by the abbreviation BMW.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2a9ef301-d433-4eb1-9b4a-b944d81afa0a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BMW>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BMW>>(v1);
    }

    // decompiled from Move bytecode v6
}

