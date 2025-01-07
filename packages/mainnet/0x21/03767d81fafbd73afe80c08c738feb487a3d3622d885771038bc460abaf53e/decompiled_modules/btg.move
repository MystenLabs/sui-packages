module 0x2103767d81fafbd73afe80c08c738feb487a3d3622d885771038bc460abaf53e::btg {
    struct BTG has drop {
        dummy_field: bool,
    }

    fun init(arg0: BTG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BTG>(arg0, 9, b"BTG", b"Bitcoin Go", b"Bitcoin go", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/08f1315c-b0be-4e75-bea4-68cf9833a5e1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BTG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BTG>>(v1);
    }

    // decompiled from Move bytecode v6
}

