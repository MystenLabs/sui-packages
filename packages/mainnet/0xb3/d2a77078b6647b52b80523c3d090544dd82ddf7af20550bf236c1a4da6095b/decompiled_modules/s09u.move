module 0xb3d2a77078b6647b52b80523c3d090544dd82ddf7af20550bf236c1a4da6095b::s09u {
    struct S09U has drop {
        dummy_field: bool,
    }

    fun init(arg0: S09U, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<S09U>(arg0, 9, b"S09U", b"Web3", b"Web3 tokens, also known as cryptocurrency tokens, are digital assets issued on blockchain networks, typically representing ownership, utility, or governance rights. Here are key aspects to consider when evaluating Web3", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5264b2ee-2dad-4636-a7d5-efdb44629c12.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<S09U>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<S09U>>(v1);
    }

    // decompiled from Move bytecode v6
}

