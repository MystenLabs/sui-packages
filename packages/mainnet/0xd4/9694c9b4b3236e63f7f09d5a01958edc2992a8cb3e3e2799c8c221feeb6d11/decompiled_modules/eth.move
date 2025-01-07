module 0xd49694c9b4b3236e63f7f09d5a01958edc2992a8cb3e3e2799c8c221feeb6d11::eth {
    struct ETH has drop {
        dummy_field: bool,
    }

    fun init(arg0: ETH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ETH>(arg0, 9, b"ETH", b"Eth", b"Etherum", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d3bbea90-85d4-40b3-baa1-0304ae3ce3c1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ETH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETH>>(v1);
    }

    // decompiled from Move bytecode v6
}

