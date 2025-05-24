module 0xc1c5bc559a5bc2fa09e0ca0cedde100562b1792d52bbf7e75b770a819a34e7ed::blob {
    struct BLOB has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLOB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLOB>(arg0, 6, b"BLOB", b"Blobbu Sui", b"Blobbu the Cutest Jellyfish Pirate Sailing Sui Network!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreiewvgwj2akc3ini2fnyzyncaem4ccqaplpqi7f55l3wpcixnit5k4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLOB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<BLOB>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

