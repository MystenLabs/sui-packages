module 0xf30edcd1ced1b74339b5989ee63058fcbc59888e5d67182faf13d7b94b986a57::pox {
    struct POX has drop {
        dummy_field: bool,
    }

    fun init(arg0: POX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POX>(arg0, 9, b"POX", b"pokedex", b"pokedex is a meme token based on the sui network", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1b8bd337-6a3f-4970-ac5b-9dedd9df73ad.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POX>>(v1);
    }

    // decompiled from Move bytecode v6
}

