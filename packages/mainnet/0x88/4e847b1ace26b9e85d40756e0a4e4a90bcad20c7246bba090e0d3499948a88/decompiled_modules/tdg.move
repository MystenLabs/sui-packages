module 0x884e847b1ace26b9e85d40756e0a4e4a90bcad20c7246bba090e0d3499948a88::tdg {
    struct TDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TDG>(arg0, 9, b"TDG", b"TDog", b"Tired Dog Meme Coin", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2bdcd3e9-4c33-44ae-b8e8-55cfb7032c93.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TDG>>(v1);
    }

    // decompiled from Move bytecode v6
}

