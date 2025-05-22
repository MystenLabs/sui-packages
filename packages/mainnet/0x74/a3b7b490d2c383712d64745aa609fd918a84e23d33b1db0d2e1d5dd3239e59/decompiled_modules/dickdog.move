module 0x74a3b7b490d2c383712d64745aa609fd918a84e23d33b1db0d2e1d5dd3239e59::dickdog {
    struct DICKDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DICKDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DICKDOG>(arg0, 6, b"DickDog", b"Buy The Dicks", b"My name is Dick and I am a dog. Do you want some DickDog?", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreicugowc5bjtscxn5ll6a6zwxlyseaiad2gpgzqc7jm5yeuii2gcoy")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DICKDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DICKDOG>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

