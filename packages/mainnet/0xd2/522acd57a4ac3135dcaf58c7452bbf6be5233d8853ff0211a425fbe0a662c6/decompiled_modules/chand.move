module 0xd2522acd57a4ac3135dcaf58c7452bbf6be5233d8853ff0211a425fbe0a662c6::chand {
    struct CHAND has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAND, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHAND>(arg0, 9, b"CHAND", b"CAT HAND", b"CATTO ON A HAND", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/30ef0d65-49b8-49f6-bc3d-770c527885b3.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAND>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CHAND>>(v1);
    }

    // decompiled from Move bytecode v6
}

