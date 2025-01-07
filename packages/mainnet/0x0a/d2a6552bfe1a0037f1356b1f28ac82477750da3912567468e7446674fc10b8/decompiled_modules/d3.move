module 0xad2a6552bfe1a0037f1356b1f28ac82477750da3912567468e7446674fc10b8::d3 {
    struct D3 has drop {
        dummy_field: bool,
    }

    fun init(arg0: D3, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<D3>(arg0, 9, b"D3", b"NexusD3", b"This token is created for Angels in crypto. An angel in crypto is someone who knows no losses, a lucky person and is created to prove that he is this world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/98bbc9f0-be7a-4828-81de-2d60501074e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<D3>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<D3>>(v1);
    }

    // decompiled from Move bytecode v6
}

