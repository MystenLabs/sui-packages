module 0x63b59c8c28e2c3880d3dfd1541fba402d62d082880771d07016a425e6968e099::nice {
    struct NICE has drop {
        dummy_field: bool,
    }

    fun init(arg0: NICE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NICE>(arg0, 9, b"NICE", b"Niceguy ", b"A decentralized cryptocurrency powering a network of creators, innovators, and change-makers.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d8eae70c-3644-43a8-8662-790614d12d77.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NICE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NICE>>(v1);
    }

    // decompiled from Move bytecode v6
}

